Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8A2A0BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgJ3Qta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgJ3Qt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:49:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB28C0613CF;
        Fri, 30 Oct 2020 09:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bLkVPUZj71HqYK7QTvtXQx4ZFoQRz5HBYZMu9LxVxOk=; b=bQ54/X+nUFyGnYfsDHFjttzPMr
        EkV0OjHqDeWDb9DwMfZM+LTYjGA2KivyIVg3dhIuj68A0GI6Imqf2JYgh38YJlqVwnOcybT1FwT7V
        n+txOHf0jpbRyf+UxLMP7XIL0mx2y7vEoZiNHJSZGC9m/jxGW/6SnN8k3Zk5PGw9BJ5uvE/9UhAem
        aPQ2GmIV3HotoN3oMes1tNQ0OdMOk4Lra4JoCDgFiNLn2Q0VbHbsZ6UC4WsM9b22J9DrKxW/e9t52
        EvNPqGoQge0kROLYZ5ekDd6GgtIlCnKdrHfEAo3OfzqH6xaZllyK1uCDo8A0YCJSuQXrOGAMLz1+C
        pbEQoSAQ==;
Received: from [2601:1c0:6280:3f0::371c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYXab-0008UR-PW; Fri, 30 Oct 2020 16:49:22 +0000
Subject: Re: [PATCH v2 26/39] docs: Kconfig/Makefile: add a check for broken
 ABI files
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
 <57a38de85cb4b548857207cf1fc1bf1ee08613c9.1604042072.git.mchehab+huawei@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4bc8b5ff-4797-4fa9-c2fe-5813be18d50b@infradead.org>
Date:   Fri, 30 Oct 2020 09:49:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <57a38de85cb4b548857207cf1fc1bf1ee08613c9.1604042072.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,


On 10/30/20 12:40 AM, Mauro Carvalho Chehab wrote:
> The files under Documentation/ABI should follow the syntax
> as defined at Documentation/ABI/README.
> 
> Allow checking if they're following the syntax by running
> the ABI parser script on COMPILE_TEST.
> 
> With that, when there's a problem with a file under
> Documentation/ABI, it would produce a warning like:
> 
> 	Warning: file ./Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats#14:
> 		What '/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor' doesn't have a description
> 	Warning: file ./Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats#21:
> 		What '/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal' doesn't have a description
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/Kconfig  | 10 ++++++++++
>  Documentation/Makefile |  5 +++++
>  lib/Kconfig.debug      |  2 ++
>  scripts/get_abi.pl     | 14 +++++++++++---
>  4 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/Kconfig b/Documentation/Kconfig
> index 66046fa1c341..e549a61f4d96 100644
> --- a/Documentation/Kconfig
> +++ b/Documentation/Kconfig
> @@ -10,4 +10,14 @@ config WARN_MISSING_DOCUMENTS
>  
>  	   If unsure, select 'N'.
>  
> +config WARN_ABI_ERRORS
> +	bool "Warn if there are errors at ABI files"
> +	depends on COMPILE_TEST
> +	help
> +	   The files under Documentation/ABI should follow what's
> +	   described at Documentation/ABI/README. Yet, as they're manually
> +	   written, it would be possible that some of those files would
> +	   have errors that would break them for being parsed by
> +	   scripts/get_abi.pl. Add a check to verify them.
>  
> +	   If unsure, select 'N'.

I need a bot for this:

Please follow coding-style for Kconfig files:

from Documentation/process/coding-style.rst, section 10):

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.



thanks.
-- 
~Randy

