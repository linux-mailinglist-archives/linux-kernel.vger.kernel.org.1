Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630DD1EFF61
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 19:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgFERtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 13:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgFERtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:49:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91140C08C5C2;
        Fri,  5 Jun 2020 10:49:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 19ABA2A50A4
Subject: Re: [PATCH] docs: block: Create blk-mq documentation
To:     Randy Dunlap <rdunlap@infradead.org>, axboe@kernel.dk,
        corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com
References: <20200527200939.77452-1-andrealmeid@collabora.com>
 <63d78a87-0953-ada4-266d-42279f4351d8@infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <8f4997dd-f68b-cb57-14e2-379914dc14ee@collabora.com>
Date:   Fri, 5 Jun 2020 14:49:07 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <63d78a87-0953-ada4-266d-42279f4351d8@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

On 5/27/20 6:58 PM, Randy Dunlap wrote:
> On 5/27/20 1:09 PM, André Almeida wrote:
>> Create a documentation providing a background and explanation around the
>> operation of the Multi-Queue Block IO Queueing Mechanism (blk-mq).

<snip>

>> +Hardware dispatch queues
>> +~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The hardware queue is a memory space shared with the block device (e.g. DMA)
>> +where the hardware can access and dispatch requests (represented by struct
>> +:c:type:`blk_mq_hw_ctx`). To run this queue, the block layer removes
>> +requests from the associated software queues and tries to dispatch to the
>> +hardware.
> 
> This paragraph (above) says to me that these HW devices understand struct blk_mq_hw_ctx.
> Is that correct?  Is is some kind of standard?  If so, where?
> 

This wasn't what I intended to say here. The struct blk_mq_hw_ctx is an
abstraction from the blk-mq API used by device drivers to map the
submission queue of the hardware. So no, HW devices can't understand
struct blk_mq_hw_ctx. This paragraph was reworked for v2.

> 
> thanks for the documentation.
> 

Thanks for the feedback.
