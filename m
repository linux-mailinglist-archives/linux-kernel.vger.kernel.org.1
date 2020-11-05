Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920752A7978
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbgKEIcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:32:12 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:46426 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgKEIcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:32:12 -0500
Received: from srv.home ([10.8.0.1] ident=heh3124)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kaaf7-00007q-Cx; Thu, 05 Nov 2020 16:30:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=EAzuQsKFvGCjWyTieL8EDA2Lu4zb0kRlOtqDXOXAFLU=;
        b=NpsWSGYdJIIiqvpbRmvZffytKFy+Xd79i2dvAo+57LZ5qijn1RFPvxGFsA4Ynz0yRVHmA2Obd4F8joEhU+twRs0J4AxI2tsy8QM09greJ1qw4uyzlrHHFKwUOrR7cE4CPDn/Uw7Xv/BTG1xLgPxGoKWVUylFyfD4RTjL/J9cdgw=;
Subject: Re: [PATCH] applesmc: Re-work SMC comms v2
To:     Henrik Rydberg <rydberg@bitmath.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
References: <20200930105442.3f642f6c@aktux>
 <20200930164446.GB219887@roeck-us.net>
 <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
 <20201002002251.28462e64@aktux>
 <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
 <20201006090226.4275c824@kemnade.info>
 <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
 <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
 <20201104142057.62493c12@aktux>
 <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
 <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
 <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
 <10027199-5d31-93e7-9bd8-7baaebff8b71@roeck-us.net>
 <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
 <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
From:   Brad Campbell <brad@fnarfbargle.com>
Message-ID: <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
Date:   Thu, 5 Nov 2020 19:30:26 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/20 6:56 pm, Henrik Rydberg wrote:
> Hi Brad,
> 
> Great to see this effort, it is certainly an area which could be improved. After having seen several generations of Macbooks while modifying much of that code, it became clear that the SMC communication got refreshed a few times over the years. Every tiny change had to be tested on all machines, or kept separate for a particular generation, or something would break.
> 
> I have not followed the back story here, but I imagine the need has arisen because of a new refresh, and so this patch only needs to strictly apply to a new generation. I would therefore advice that you write the patch in that way, reducing the actual change to zero for earlier generations. It also makes it easier to test the effect of the new approach on older systems. I should be able to help testing on a 2008 and 2011 model once we get to that stage.

G'day Henrik,

Unfortunately I didn't make these changes to accommodate a "new generation". Changes made in kernel 5.9 broke it on my machine and in looking at why didn't identify any obvious causes, so I re-worked some of the comms.

I can't guarantee it won't break older machines which is why I've asked for help testing it. I only have a MacbookPro 11,1 and an iMac 12,2. It fixes both of those.

Help testing would be much appreciated.

Regards,
Brad
