Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024232FF6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbhAUVPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:15:03 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.232.172]:49422 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727085AbhAUU5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 15:57:18 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 6C4CD46B32;
        Thu, 21 Jan 2021 12:56:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6C4CD46B32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611262577;
        bh=eYhNwwTn1bALpgeS+eXfEH6620QkIt6R1FEbTfM0Zdk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FTbvtvuB24fScFgMqFbjcb2VVG8RjV2h8O8xpot8IoRslhlaAAsdWwWzn3FbBUBjD
         69bp9Y0Q/n46zh0tKACcZbxHLrxpOFqhR1/ehvgdZbYF5VXAdcEZ+EXXYpUPVczUxX
         lRUHvCm/Xma2Bg1NGK670Pvu/Sk0qb/OPoQpN4tQ=
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang line
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Finn Behrens <me@kloenk.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210121170736.2266-1-scott.branden@broadcom.com>
 <CAK7LNAQEvej1_UrS6s1+vwdei8cK1UW8b5erYc-6Ggu25oC0cg@mail.gmail.com>
 <CAHp75Vf=Ba+e8PDsvi8eDiuNDvC6Pfx3RsRAkaOZvD26Z2pnQA@mail.gmail.com>
 <CAHp75VcLi8hjYaDXrfAjbj+Kw_FRef=xnKiXr_Kv+YUToEjHTQ@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <fad34db6-a8b7-a49a-3c45-d51a6fe10d6a@broadcom.com>
Date:   Thu, 21 Jan 2021 12:56:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcLi8hjYaDXrfAjbj+Kw_FRef=xnKiXr_Kv+YUToEjHTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2021-01-21 12:35 p.m., Andy Shevchenko wrote:
> On Thu, Jan 21, 2021 at 10:31 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Thu, Jan 21, 2021 at 10:28 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>> On Fri, Jan 22, 2021 at 2:17 AM Scott Branden
>>> <scott.branden@broadcom.com> wrote:
>>>> Use python3 instead of python in diffconfig Shebang line.
>>>> python2 was sunset January 1, 2000 and environments do not need
>>>> to support python any more.
>>> Just from curiosity, what problem is this solving?
>>>
>>> Is there a distribution where 'python' does not exist,
>>> but 'python3' does ?
>> Yes. Called surprise surprise Debian
>> An it's a rare case when I agree with them.
> For the record, you seems haven't noticed:
> https://lkml.org/lkml/2020/12/9/446
It doesn't look like your change made it into 5.11-rc but I think it should be added?

