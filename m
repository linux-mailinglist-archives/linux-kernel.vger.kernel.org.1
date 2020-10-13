Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67B728C762
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 04:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgJMCyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 22:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgJMCyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:54:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99415C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 19:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=z+iglNwhclZAMPArJ2jEHjJ69tR4KECRW+Be9D54RpE=; b=QFCJ11b8qwAq3cp2FeCnGV8SPd
        SXI4dswkjiXcCljKUfd1+yYqfTes7/FtUf/DB/bn57Ggwuz2O1MJFnaQ76L2+IrrggClqUwVo/MFV
        XFplOUBKtI3RbT+YPGoN+qRF1MbadzyN8JdW+wMdBK6ymBbl7DH+d6vsXreCqIFQhcn8XExrqKiOz
        EUdkY+3+66tgSDdednNdpBxakzIHSdx3v1WkywYg4YqrwdIIgKdCH2mdI6QPAkDCJZOuqHZqnw3xA
        JU7a/SDboy/pDFfLO+DgQdVBzI2CuV9x5azQxwdQ/QuvQa73i18DuX9myjTE2NZNWt1gVz84NyCOD
        5/2xSeRw==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSASR-0006mj-Mh; Tue, 13 Oct 2020 02:54:36 +0000
Subject: Re: [PATCH v2 1/2] Documentation: x86: Rename resctrl_ui.rst and add
 two errata to the file
To:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <20201013024656.700492-1-fenghua.yu@intel.com>
 <20201013024656.700492-2-fenghua.yu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <30bf0281-4680-0a6a-b06b-d86633f534ad@infradead.org>
Date:   Mon, 12 Oct 2020 19:54:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013024656.700492-2-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 7:46 PM, Fenghua Yu wrote:
> Intel Memory Bandwidth Monitoring (MBM) counters may report system
> memory bandwidth incorrectly on some Intel processors. The errata are
> reported in erratum SKX99 [1], erratum BDF102 [2] and RDT reference
> manual [3].
> 
> To work around the errata, MBM total and local readings are corrected
> using a correction factor table.
> 
> Since the correction factor table is not publicly documented anywhere,
> the table and the errata are documented in Documentation/x86/resctrl.rst
> for future reference. The resctrl.rst file is renamed from
> Documentation/x86/resctrl_ui.rst because the file won't contain user
> interface only anymore.
> 
> 1. Erratum SKX99 in Intel Xeon Processor Scalable Family Specification
>    Update:
> http://web.archive.org/web/20200716124958/https://www.intel.com/content/www/us/en/processors/xeon/scalable/xeon-scalable-spec-update.html
> 2. Erratum BDF102 in Intel Xeon E5-2600 v4 Processor Product Family
>    Specification Update:
> http://web.archive.org/web/20191125200531/https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/xeon-e5-v4-spec-update.pdf
> 3. The errata in Intel Resource Director Technology (Intel RDT) on 2nd
>    Generation Intel Xeon Scalable Processors Reference Manual:
> https://software.intel.com/content/www/us/en/develop/articles/intel-resource-director-technology-rdt-reference-manual.html
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
> Change Log:
> v2:
> - Document the correction factor table and errata in resctrl.rst (Boris).
> - Change the documentation URLs to stable archive.org (Tony).
> 
>  Documentation/conf.py                         |  2 +-
>  Documentation/x86/index.rst                   |  2 +-
>  .../x86/{resctrl_ui.rst => resctrl.rst}       | 82 +++++++++++++++++++
>  3 files changed, 84 insertions(+), 2 deletions(-)
>  rename Documentation/x86/{resctrl_ui.rst => resctrl.rst} (92%)
> 
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index c503188880d9..b5b2be8eec22 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -36,7 +36,7 @@ needs_sphinx = '1.3'
>  # Add any Sphinx extension module names here, as strings. They can be
>  # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
>  # ones.
> -extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
> +extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
>                'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
>                'maintainers_include', 'sphinx.ext.autosectionlabel' ]

Hi,
I don't see this change described in the patch description.
Should it be here?

thanks.
-- 
~Randy

