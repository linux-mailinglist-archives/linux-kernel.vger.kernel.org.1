Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6AC277EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 06:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgIYEVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 00:21:53 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35604 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgIYEVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 00:21:53 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08P4LK0O092644;
        Thu, 24 Sep 2020 23:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601007680;
        bh=9SifCwElBwvcn4Om8He06UDzfh65tOYD13ogczUrHzs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=linujbdFDLAGzmv/VdyoPJVYuapz6AVWMbfJFsRJi6KCThUktCoS3sftKqDnDf4LO
         sydAL5HavxBaCfgxuZKhkJSW9g56Zk93sIKl0WYogsu8kMbqFXMpr+BPpcfcYX+BDs
         Shtrp0eCww3fpH7PZ2FXJxA6VOpdhrdDWnv/PDFo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08P4LK8F060733
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 23:21:20 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 23:21:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 23:21:20 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08P4LEEL109221;
        Thu, 24 Sep 2020 23:21:15 -0500
Subject: Re: [PATCH] mtd: spi-nor: controllers: intel-spi: Add support for
 command line partitions
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Ronald G. Minnich" <rminnich@gmail.com>
CC:     "Ronald G. Minnich" <rminnich@google.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20200417152613.176554-1-rminnich@google.com>
 <20200417160736.GE2586@lahna.fi.intel.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1887c783-7a80-a71c-949f-c07c83c2d0fe@ti.com>
Date:   Fri, 25 Sep 2020 09:51:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200417160736.GE2586@lahna.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/20 9:37 PM, Mika Westerberg wrote:
> On Fri, Apr 17, 2020 at 08:26:11AM -0700, Ronald G. Minnich wrote:
>> On Intel platforms, the usable SPI area is located several
>> MiB in from the start, to leave room for descriptors and
>> the Management Engine binary. Further, not all the remaining
>> space can be used, as the last 16 MiB contains firmware.
>>
>> To make the SPI usable for mtdblock and other devices,
>> it is necessary to enable command line partitions so the
>> middle usable region can be specified.
>>
>> Add a part_probes array which includes only "cmdelineparts",
>> and change to mtd_device_parse_register to use this part_probes.
>>
>> Signed-off-by: Ronald G. Minnich <rminnich@google.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 

scripts/checkpatch.pl --strict complains:

CHECK: Alignment should match open parenthesis
#46: FILE: drivers/mtd/spi-nor/controllers/intel-spi.c:956:
+	ret = mtd_device_parse_register(&ispi->nor.mtd, part_probes,
+				       NULL, &part, 1);

WARNING: Missing Signed-off-by: line by nominal patch author '"Ronald G. Minnich" <rminnich@gmail.com>'

Regards
Vignesh
