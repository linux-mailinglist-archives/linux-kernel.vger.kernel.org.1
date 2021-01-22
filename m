Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429E73009CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbhAVR3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:29:31 -0500
Received: from lpdvacalvio01.broadcom.com ([192.19.229.182]:47666 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727784AbhAVQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:47:43 -0500
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 6DF7E2256B;
        Fri, 22 Jan 2021 08:46:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6DF7E2256B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1611334000;
        bh=z/77B/bHtuelbE/OBTvVS+tmCp8yIQ/RCn1z5xp56J4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lhBIxN1D0BgHa18H3snRITZlwFlIHYmyFjtfBzlImyiA8AA++nbnpuOLay3wOFxnj
         c9KuMjeuRp2zMQ9dXNYcGSOyge6SMruuwX0HJva5tnAzjLz/JD+jGRavCHmYhe/1tj
         uuoAVpyydPzt4endd4UdzrmZzTzPEK2Fqreme8IM=
Subject: Re: [PATCH] diffconfig: use python3 instead of python in Shebang line
To:     Joe Perches <joe@perches.com>,
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
 <b9c303e70dc4f8573bebb6bb07c98daa25ea0fba.camel@perches.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <e28bddaf-24af-8216-1b66-bca003810050@broadcom.com>
Date:   Fri, 22 Jan 2021 08:46:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b9c303e70dc4f8573bebb6bb07c98daa25ea0fba.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-01-21 6:18 p.m., Joe Perches wrote:
> On Fri, 2021-01-22 at 05:25 +0900, Masahiro Yamada wrote:
>> On Fri, Jan 22, 2021 at 2:17 AM Scott Branden
>> <scott.branden@broadcom.com> wrote:
>>> Use python3 instead of python in diffconfig Shebang line.
>>> python2 was sunset January 1, 2000 and environments do not need
>>> to support python any more.
> python2 was sunset Jan 1, 2020, not 20 years before that.
>
> https://www.python.org/doc/sunset-python-2/
With the past year: Jan 1, 2020 seems about 20 years ago.
>
>

