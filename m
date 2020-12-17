Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183B72DCDAE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgLQIch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:32:37 -0500
Received: from goliath.siemens.de ([192.35.17.28]:45587 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgLQIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:32:37 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 0BH8VlvP012074
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 09:31:47 +0100
Received: from [167.87.38.225] ([167.87.38.225])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0BH8VkiK008935;
        Thu, 17 Dec 2020 09:31:46 +0100
Subject: Re: [PATCH v2] gdb: lx-symbols: store the abspath()
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
References: <20201217091747.bf4332cf2b35.I10ebbdb7e9b80ab1a5cddebf53d073be8232d656@changeid>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <60d43738-1d89-30b0-54bd-8303daeadc57@siemens.com>
Date:   Thu, 17 Dec 2020 09:31:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217091747.bf4332cf2b35.I10ebbdb7e9b80ab1a5cddebf53d073be8232d656@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.20 09:17, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> If we store the relative path, the user might later cd to a
> different directory, and that would break the automatic symbol
> resolving that happens when a module is loaded into the target
> kernel. Fix this by storing the abspath() of each path given,
> just like we already do for the cwd (os.getcwd() is absolute.)
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v2: break the long line
> ---
>  scripts/gdb/linux/symbols.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index 1be9763cf8bb..08d264ac328b 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -164,7 +164,8 @@ lx-symbols command."""
>              saved_state['breakpoint'].enabled = saved_state['enabled']
>  
>      def invoke(self, arg, from_tty):
> -        self.module_paths = [os.path.expanduser(p) for p in arg.split()]
> +        self.module_paths = [os.path.abspath(os.path.expanduser(p))
> +                             for p in arg.split()]
>          self.module_paths.append(os.getcwd())
>  
>          # enforce update
> 

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
