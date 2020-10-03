Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6EF28226F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 10:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725769AbgJCIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 04:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgJCIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 04:24:48 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7CBC0613D0;
        Sat,  3 Oct 2020 01:24:47 -0700 (PDT)
Received: from ip4d14bc8c.dynamic.kabel-deutschland.de ([77.20.188.140] helo=[192.168.66.101]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kOcqT-0001cP-WF; Sat, 03 Oct 2020 10:24:46 +0200
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <b81c54734a767f7da9ec68fae6b82ea0a8c96011.1601541165.git.linux@leemhuis.info>
 <b7ab110b-3f4d-382c-5802-5dd4291ea118@infradead.org>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Autocrypt: addr=linux@leemhuis.info; prefer-encrypt=mutual; keydata=
 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
 5iv6NKaV29GWHbY=
Subject: Re: [RFC PATCH v1 04/26] docs: reporting-bugs: step-by-step guide for
 issues in stable & longterm
Message-ID: <bb7adae8-25ae-9057-717e-c95bad30be6d@leemhuis.info>
Date:   Sat, 3 Oct 2020 10:24:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b7ab110b-3f4d-382c-5802-5dd4291ea118@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1601713487;f747b745;
X-HE-SMSGID: 1kOcqT-0001cP-WF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many thx for you comments. Consider all the obvious spelling and
grammatical mistakes you pointed out fixed, I won't mention them in this
reply to keep things easier to follow.

Am 02.10.20 um 05:25 schrieb Randy Dunlap:
> On 10/1/20 1:39 AM, Thorsten Leemhuis wrote:

>> + * Check if the kernel developers still maintain the Linux kernel version line
>> +   you care about: go to `the front-page of kernel.org <https://kernel.org>`_
>> +   and make sure it mentions the latest release of the particular version line
>> +   without an '[EOL]' tag.
> Explain somewhere that EOL = End Of Life (in parens).

The section that describes this step in more detail explains the
acronym. To keep this section short I'd like to omit the explanation
here, as it's a pretty well known term anyway. Hope that's okay for you.

Ciao, Thorsten
