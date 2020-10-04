Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A828287E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 06:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgJDEDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 00:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgJDEDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 00:03:22 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3333C0613CE;
        Sat,  3 Oct 2020 21:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:Subject:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=uKa66ETGBRVskV1YBqgXWXxLBGG5d7Kkd2GNGl5nYaQ=; b=Jcu826RBxpEVXCXTJoxurPCm+F
        5y7+ayIjDSlK1QTo27Svu6cR30MVHY6/b6Q9yGoRUmxL+bY10SjqCE62M1HBbhwqGe3VqkE463/Ue
        XuiHZSfPAsPGdM7KKCaSyyn/rtcqN6wQXX+xkurQxBc46IyKU4BSR/iqp7NESlW+9ItlbhXxFR3vf
        ZBxqRw0rTOw5xj6VAgYV05qf4oPWPTYB9/Dsgq1S4HZoYCvPuMK+49thiqOZXDgXllH7zYGgu4j/s
        UfYz5mfTdy+x7NiFmTN2DXdIecNmN/uRv0+A9WF49AZYx+ugRugUOUNYHZ5z1yOSPeEVTK/GYThBS
        25mdahdw==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOvF2-00058y-IY; Sun, 04 Oct 2020 04:03:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v1 25/26] docs: reporting-bugs: explain things could
 be easier
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1601541165.git.linux@leemhuis.info>
 <42d0e4956abf7ea2b0ea15f56afb1720a11739f1.1601541165.git.linux@leemhuis.info>
Message-ID: <97280e05-054f-043d-9d2a-4944611640bc@infradead.org>
Date:   Sat, 3 Oct 2020 21:03:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <42d0e4956abf7ea2b0ea15f56afb1720a11739f1.1601541165.git.linux@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 1:50 AM, Thorsten Leemhuis wrote:
> A few closing words to explain why things are like this until someone
> steps up to make things easier for people.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-bugs.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/admin-guide/reporting-bugs.rst b/Documentation/admin-guide/reporting-bugs.rst
> index 8f60af27635b..42f59419263a 100644
> --- a/Documentation/admin-guide/reporting-bugs.rst
> +++ b/Documentation/admin-guide/reporting-bugs.rst
> @@ -1458,6 +1458,15 @@ But don't worry too much about all of this, a lot of drivers have active
>  maintainers who are quite interested in fixing as many issues as possible.
>  
>  
> +Closing words
> +=============
> +
> +Compared with other Free/Libre & Open Source Software it's hard to reporting

                                                                   to report

> +issues to the Linux kernel developers: the length and complexity of this
> +document and the implications between the lines illustrate that. But that's how
> +it is for now. The main author of this text hopes documenting the state of the
> +art will lay some groundwork to improve the situation over time.
> +
>  .. ############################################################################
>  .. Temporary marker added while this document is rewritten. Sections above
>  .. are new and dual-licensed under GPLv2+ and CC-BY 4.0, those below are old.
> 


-- 
~Randy

