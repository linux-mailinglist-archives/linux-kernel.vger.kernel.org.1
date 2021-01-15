Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34B2F82D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbhAORqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbhAORqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:46:20 -0500
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 15 Jan 2021 09:45:39 PST
Received: from mta02.hs-regensburg.de (mta02.hs-regensburg.de [IPv6:2001:638:a01:1096::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AD9C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:45:39 -0800 (PST)
Received: from E16S02.hs-regensburg.de (e16s02.hs-regensburg.de [IPv6:2001:638:a01:8013::92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client CN "E16S02", Issuer "E16S02" (not verified))
        by mta02.hs-regensburg.de (Postfix) with ESMTPS id 4DHSy61sYPzy2f;
        Fri, 15 Jan 2021 18:35:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oth-regensburg.de;
        s=mta01-20160622; t=1610732142;
        bh=pdCcdwTUbR3QK4nTz61ezzePIwOXPkcQ1E2uYeP1pd0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=MiV8hnN/GOVwXjOh39TkTEKKMuWP5gTkpSOlwhuQC2Q7l8qxKSsrfR+Yj5DMSaH9E
         y9s/PhruA2eIaMuB13MYrwd6OfPXaq1uqKDjW2pBHG/FUwNnS8yTnXlNn0yokoUZiO
         oPzNxE9ezZXCsIUnMDbSIBHocF0bbZx9HxG9Dn8bWwQq0UUqaHmnIunBmPSHDdXjE+
         O5NjXW+qkmvY5AsCPk5ELrzgysbf+C8qrY0mmu7Qot7maue+TcI/6J6aYfgXloZxVb
         UMsWg2WszOL6ZcdMzqYEzAXIlD/XVFpSVLMLc03HvCBx2VXja3dV2TNDFO3QZgh8ao
         ocvXqxtfIxMbg==
Received: from Gauge-Invariance.local (194.95.106.138) by
 E16S02.hs-regensburg.de (2001:638:a01:8013::92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 15 Jan 2021 18:35:42 +0100
Subject: Re: [EXT] Re: Related work to MAINTAINERS truth and fiction
To:     Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
References: <CAKXUXMzj=LYJK74Le+rYnAaY3ji6AxugppwHwneAEL_xTTAyGw@mail.gmail.com>
 <20210115095246.653748af@lwn.net>
From:   Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Message-ID: <3772cc53-61c6-7d95-5486-3b205a1e738f@oth-regensburg.de>
Date:   Fri, 15 Jan 2021 18:35:41 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115095246.653748af@lwn.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.95.106.138]
X-ClientProxiedBy: E16S02.hs-regensburg.de (2001:638:a01:8013::92) To
 E16S02.hs-regensburg.de (2001:638:a01:8013::92)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 15/01/2021 um 17:52 schrieb Jonathan Corbet:
> On Fri, 15 Jan 2021 07:57:51 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> 
>> Pia Eichinger has done some related analysis and work in this area as
>> part of her bachelor's thesis on Maintainers Expectations vs.
>> Maintainers Reality: An Analysis of Organisational and Maintenance
>> Structure of the Linux Kernel. Simply quoting her conclusion:
>>
>> "We showed that around 20% of all patches were theoretically wrongly
>> integrated when strictly analysing MAINTAINERS. The reality of
>> integration and maintenance structure is more complicated than that,
>> which we also explored. Furthermore, we identified 12 major subsystems
>> of the Linux kernel. This is very helpful for an overview of the
>> organisational structure, realistic grouping of subsystems and further
>> Linux kernel topology discussions."
>>
>> Announcement and thesis here:
>> https://lists.elisa.tech/g/devel/message/1269
>> https://drive.google.com/file/d/12ta2YxgEzEfrIcmWid8kwIyVEywbUjbA/view?usp=sharing
> 
> Interesting, I was completely unaware of this work.  I blame Wolfgang, who
> should have pointed it out to me :)

well, I do accept .8 of the blame. For the remaining .2, I have to
say that with a little time travel in forward direction (especially
since we're not doing isochronous spatial travel any more!), you could
have easily seen Pia's presentation at LCA in a week or so :)

Actually, I was planning on pitching the results to you for lwn; if you
find there are some aspects left in the work that you have not covered
yet, and that's interesting for the community, we'd of course be happy
to contribute a short piece. Pia will post a repo link for the analysis
soon.

Thanks, Wolfgang


> 
> Thanks,
> 
> jon
> 
