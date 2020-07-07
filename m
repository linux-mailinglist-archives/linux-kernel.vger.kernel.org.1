Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B142167F5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 10:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgGGIDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 04:03:52 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:50360 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgGGIDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:03:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id AC3CD2016B15;
        Tue,  7 Jul 2020 16:03:48 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z6WMaQd-Zdfo; Tue,  7 Jul 2020 16:03:48 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 87C1C20160D4;
        Tue,  7 Jul 2020 16:03:48 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.79])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 0C3ECC01F9E;
        Tue,  7 Jul 2020 16:03:47 +0800 (HKT)
Subject: Re: [PATCH v3 0/2] shtc1: add support for device tree bindings
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200707080104.23711-1-chris.ruehl@gtsys.com.hk>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <c7f4805a-0cdf-ea5b-7557-c4f00fec6ee8@gtsys.com.hk>
Date:   Tue, 7 Jul 2020 16:03:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707080104.23711-1-chris.ruehl@gtsys.com.hk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/7/2020 4:01 pm, Chris Ruehl wrote:
> Add support for DTS bindings to the shtc driver
> The patches add the compatible table and of_property_read_bool to the
> shtc1.c. Newly created Yaml document has been released to the
> Documentation/devicetree/hwmon/sensirion,shtc1.yaml
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>   Version 3
> 	Fix errors report with checkpatch.pl
> 	Correct logic, add (!) when check for sensirion,low_precision
>   Version 2
> 	remove the #ifdef CONFIG_OF
> 	ignore platform data if dev->of_node is valid
> 	use boolean only therefor use sensirion,low_precise to fit the logic
> 	add missing driver.of_match_table entry
>   Version 1
> 	initial version
> 

I didn't fix the WARNINGS coming up with checkpatch, they are initial commit 
errors when added to the kernel.
But I have a patch pending to fix the format issue , once this is accepted.
