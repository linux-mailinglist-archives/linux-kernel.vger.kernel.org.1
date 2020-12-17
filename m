Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B4E2DCD6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgLQILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:11:43 -0500
Received: from gecko.sbs.de ([194.138.37.40]:35638 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgLQILn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:11:43 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 0BH8Ars6018370
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Dec 2020 09:10:53 +0100
Received: from [167.87.38.225] ([167.87.38.225])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0BH8AqKj019925;
        Thu, 17 Dec 2020 09:10:53 +0100
Subject: Re: [PATCH] gdb: correct sys.path insertion
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
References: <20201216143646.82aa53af4af8.I04934c69a9f3abac5ba6d542f823898357fd0e11@changeid>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b92ec4f5-42ef-8d8c-bf37-90e1476b95e5@siemens.com>
Date:   Thu, 17 Dec 2020 09:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201216143646.82aa53af4af8.I04934c69a9f3abac5ba6d542f823898357fd0e11@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.12.20 14:36, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Perhaps something got moved around at some point, but the
> current path that gets inserted has "/scripts/gdb" twice,
> since the script is located in scripts/gdb/ already. Fix
> the path.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  scripts/gdb/vmlinux-gdb.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
> index 4136dc2c59df..476da5b6a7ca 100644
> --- a/scripts/gdb/vmlinux-gdb.py
> +++ b/scripts/gdb/vmlinux-gdb.py
> @@ -13,7 +13,7 @@
>  
>  import os
>  
> -sys.path.insert(0, os.path.dirname(__file__) + "/scripts/gdb")
> +sys.path.insert(0, os.path.dirname(__file__))
>  
>  try:
>      gdb.parse_and_eval("0")
> 

How did you test that, which setup? I just ran "gdb
<linux>/build/vmlinux", and "python print(sys.path)" didn't expose this
duplication. So your change would actually break that common case.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
