Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277EC220A92
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 12:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgGOK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 06:56:54 -0400
Received: from foss.arm.com ([217.140.110.172]:39850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgGOK4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:56:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CEA430E;
        Wed, 15 Jul 2020 03:56:53 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 100403F718;
        Wed, 15 Jul 2020 03:56:51 -0700 (PDT)
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Remove unneeded __packed
 attribute
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, sudeep.holla@arm.com
References: <20200710133919.39792-1-cristian.marussi@arm.com>
 <20200710133919.39792-2-cristian.marussi@arm.com>
 <751ee628-ff38-a383-5832-aab4905af32b@arm.com>
 <20200713130749.GA31938@e119603-lin.cambridge.arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <310a7e5a-2d6a-313a-4020-362703ceb1b8@arm.com>
Date:   Wed, 15 Jul 2020 11:56:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200713130749.GA31938@e119603-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2020 14:07, Cristian Marussi wrote:
> Hi Steven
> 
> thanks for the review.
> 
> On Mon, Jul 13, 2020 at 12:20:43PM +0100, Steven Price wrote:
>> On 10/07/2020 14:39, Cristian Marussi wrote:
>>> Remove __packed attribute from struct scmi_event_header.
>>>
>>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>>
>> A drive-by review. But this doesn't look safe to me. sizeof(struct
>> scmi_event_header) is used in several places and this change will modify
>> that from 13 to 16, but leave the structure members at the same offset (as
>> the members are naturally aligned). In particular the naï¿½ve header size is
>> now bigger than the offset to payld.
>>
>> What is the justification for __packed being 'unneeded'?
>>
> 
> Arnd pointed out at first that this structure in the original series had a mix of
> fixed and non-fixed types in its fields and that the __packed rendered some fields
> misaglined.
> 
> Removing that as it is, in fact left also some unexplained implicit padding which is
> at odd for a struct containing fixed-sized types.
> 
> In a following fix in the series I have indeed moved this struct's fields  and others
> to generic non fixed type fields and shuffled around the fields to avoid misalignment
> and implicit internal padding (except for the trailing padding due to the variable
> size array)
> 
> It was probably better to squash also this patch in that following patch.
> 
> This structure is used internally to push variable-sized (through the means of the payld[])
> events descriptors through a fifo from the ISR to the deferred workqueus, so that's whhy I
> originally thought to avoid to carry around unneeded padding into the fifos and use the
> __packed.
> 
> On the correctness side, as you pointed out, the header with padding is now 16 so when
> I push thorugh the kfifos this header and the payload there's a hole in the data as
> represented in the fifo buffer as such
> 
> @end_of hdr+payld kfifo writes:
>    kifo_in(fifo, h, sizeof(*h)) + kfifo_in(fifo, payld, h->payld_sz)
> 
> 0       14   16
> +-------+----+------------
> |header - pad| payload...
> -------------------------
>          ^
> 	|
> 	.payld
> 
> (Note that header and payload comes from two distinct place so I have push it with two kfifo_in()
> in order to avoid a redundant memcpy on an intermediate buffer to collate them...thing
> that was pointed out as undesirable in a review)
> 
> and when I read it back from the fifo such hole is just transparently overwritten:
> 
> @header read:
>   kfifo_out(fifo, h, sizeof(*h))
> 
> 0       14   16
> +-------+----+--------------
> |header - pad|
> ----------------------------
> 
> @payload_read:
>   kfifo_out(fifo, h->payld, h->payld_sz)
> 
> 0       14
> +-------+----+--------------
> |header | payload....
> ----------------------------
>          ^
> 	|
> 	.payld
> 
> So since anyway the drawback of packing is that the misaglined access potentially slows down the
> reads, I was not sure anymore it was worth to pack and misalign, and, given that it seemed not
> to be liked so much, I dropped it and moved to generic non-fixed types without packing.

Thanks for the explanation - it sounds like the change is correct.

However, from the description above it sounds like splitting the header 
and payload into separate types would be clearer. I'm not sure the 
flexible length array is adding to code clarity here. In particular the 
'pad' being put into the fifo is actually going to be a (truncated) copy 
of the payload.

There is also a trick with an unnamed internal struct which gets the 
padding in the correct place...

	struct scmi_event_header {
		struct {
			u64	timestamp;
			u8	evt_id;
			size_t	payld_sz;
		}
		u8	payld[];
	};

...with that then...

	offsetof(struct scmi_event_header, payld) ==
		sizeof(struct scmi_event_header)

...which avoids the need for kfifo_out having to overwrite the padding.

> A better (and shorter) explanation of all of the above is possibly needed (but I'd still prefer
> the fixed sized typing and __packed 'holeless' approach...)

Fixed sized types and __packed is easier to reason about, but obviously 
naturally aligned types do tend to be faster.

Steve
