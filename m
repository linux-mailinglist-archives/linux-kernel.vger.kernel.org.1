Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3556D280E99
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgJBIS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 04:18:28 -0400
Received: from plasma31.jpberlin.de ([80.241.56.82]:30523 "EHLO
        plasma31.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgJBIS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 04:18:28 -0400
Received: from spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122])
        by plasma.jpberlin.de (Postfix) with ESMTP id 435A4100C7B;
        Fri,  2 Oct 2020 10:18:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.76])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id 12vNEUtfWTcJ; Fri,  2 Oct 2020 10:18:21 +0200 (CEST)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 2BCE51006DB;
        Fri,  2 Oct 2020 10:18:21 +0200 (CEST)
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH 6/7] dt-bindings: arm: Add virtio transport for SCMI
To:     Rob Herring <robh@kernel.org>,
        Peter Hilber <peter.hilber@opensynergy.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <virtio-dev@lists.oasis-open.org>, <linux-kernel@vger.kernel.org>,
        <sudeep.holla@arm.com>, <souvik.chakravarty@arm.com>,
        <alex.bennee@linaro.org>, <jean-philippe@linaro.org>,
        <igor.skalkin@opensynergy.com>, <mikhail.golubev@opensynergy.com>,
        <anton.yakovlev@opensynergy.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
References: <20200918162311.254564-1-peter.hilber@opensynergy.com>
 <20200918165558.257086-1-peter.hilber@opensynergy.com>
 <20200923205433.GB1285024@bogus>
Autocrypt: addr=peter.hilber@opensynergy.com; prefer-encrypt=mutual; keydata=
 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
 lbekkuPTQs/m
Message-ID: <9ba94147-8e83-1122-a900-f4b50d783909@opensynergy.com>
Date:   Fri, 2 Oct 2020 10:18:19 +0200
MIME-Version: 1.0
In-Reply-To: <20200923205433.GB1285024@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-02.open-synergy.com (10.26.10.22)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -8.23 / 15.00 / 15.00
X-Rspamd-Queue-Id: 435A4100C7B
X-Rspamd-UID: 134a58
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.09.20 22:54, Rob Herring wrote:
> On Fri, Sep 18, 2020 at 06:55:58PM +0200, Peter Hilber wrote:
>> From: Igor Skalkin <igor.skalkin@opensynergy.com>
>>
>> Document the properties for arm,scmi-virtio compatible nodes. The
>> backing virtio SCMI device is described in patch [1].
>>
>> [1] https://lists.oasis-open.org/archives/virtio-comment/202005/msg00096.html
>>
>> Co-developed-by: Peter Hilber <peter.hilber@opensynergy.com>
>> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
>> Signed-off-by: Igor Skalkin <igor.skalkin@opensynergy.com>
>> ---
>>  .../devicetree/bindings/arm/arm,scmi.txt      | 38 ++++++++++++++++++-
>>  1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
>> index 55deb68230eb..844ff3c40a49 100644
>> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
>> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
>> @@ -13,6 +13,9 @@ the device tree.
>>  Required properties:
>>  
>>  The scmi node with the following properties shall be under the /firmware/ node.
>> +Some properties are specific to a transport type.
>> +
>> +shmem-based transports (mailbox, smc/hvc):
>>  
>>  - compatible : shall be "arm,scmi" or "arm,scmi-smc" for smc/hvc transports
>>  - mboxes: List of phandle and mailbox channel specifiers. It should contain
>> @@ -21,6 +24,17 @@ The scmi node with the following properties shall be under the /firmware/ node.
>>  	  supported.
>>  - shmem : List of phandle pointing to the shared memory(SHM) area as per
>>  	  generic mailbox client binding.
>> +
>> +Virtio transport:
>> +
>> +- compatible : shall be "arm,scmi-virtio".
>> +- virtio_transport : phandle of the virtio device. This device must support one
>> +                     virtqueue for transmitting commands ("tx", cmdq), and,
>> +		     optionally, one more virtqueue for receiving notifications
>> +		     and delayed responses ("rx", eventq).
> 
> Isn't what the virtio device provides discoverable? We don't have virtio 
> protocols in DT for anything else. Why is SCMI special?
> 
> Rob
> 

Does your comment refer to the presence of the `virtio_transport'
phandle, or to the entire "arm,scmi-virtio" node? The protocol child
nodes of "arm,scmi-virtio" can be clock providers, power domain
providers, etc.

The author and me are currently looking into how to replace
the `virtio_transport' phandle.

Best regards,

Peter
