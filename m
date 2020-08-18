Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30564247DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 07:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgHRFhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 01:37:22 -0400
Received: from david.siemens.de ([192.35.17.14]:48416 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbgHRFhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:37:21 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 07I5bFNF010985
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 07:37:15 +0200
Received: from [139.22.40.250] ([139.22.40.250])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07I5bE2L025569;
        Tue, 18 Aug 2020 07:37:15 +0200
Subject: Re: [PATCH 1/2] proc: Add struct mount & struct super_block addr in
 lx-mounts command
To:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1597721575.git.riteshh@linux.ibm.com>
 <af4d266dd2d6b45403feca45395e3146a6f497cd.1597721575.git.riteshh@linux.ibm.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3babefe6-8784-dd9a-75ca-bb6ecff3106c@siemens.com>
Date:   Tue, 18 Aug 2020 07:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <af4d266dd2d6b45403feca45395e3146a6f497cd.1597721575.git.riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.20 06:04, Ritesh Harjani wrote:
> This is many times found useful while debugging some FS related issue.
> 
> <e.g. output>
>       mount          super_block      fstype devname pathname options
> 0xffff888a0bfa4b40 0xffff888a0bfc1000 rootfs none / rw   0 0
> 0xffff888a02c065c0 0xffff8889fcf65000 ext4 /dev/root / rw  ,relatime 0 0
> 0xffff8889fc8cc040 0xffff888a0bb51000 devtmpfs devtmpfs /dev rw  ,relatime 0 0
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  scripts/gdb/linux/proc.py | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/gdb/linux/proc.py b/scripts/gdb/linux/proc.py
> index 6a56bba233a9..c16fab981bdd 100644
> --- a/scripts/gdb/linux/proc.py
> +++ b/scripts/gdb/linux/proc.py
> @@ -167,6 +167,9 @@ values of that process namespace"""
>          if not namespace:
>              raise gdb.GdbError("No namespace for current process")
>  
> +        gdb.write("{:^18} {:^15} {:>9} {} {} options\n".format(
> +                  "mount", "super_block", "fstype", "devname", "pathname"))
> +
>          for vfs in lists.list_for_each_entry(namespace['list'],
>                                               mount_ptr_type, "mnt_list"):
>              devname = vfs['mnt_devname'].string()
> @@ -190,14 +193,10 @@ values of that process namespace"""
>              m_flags = int(vfs['mnt']['mnt_flags'])
>              rd = "ro" if (s_flags & constants.LX_SB_RDONLY) else "rw"
>  
> -            gdb.write(
> -                "{} {} {} {}{}{} 0 0\n"
> -                .format(devname,
> -                        pathname,
> -                        fstype,
> -                        rd,
> -                        info_opts(FS_INFO, s_flags),
> -                        info_opts(MNT_INFO, m_flags)))
> +            gdb.write("{} {} {} {} {} {} {} {} 0 0\n".format(
> +                      vfs.format_string(), superblock.format_string(), fstype,
> +                      devname, pathname, rd, info_opts(FS_INFO, s_flags),
> +                      info_opts(MNT_INFO, m_flags)))

The last three format elements should not be space-separated. The effect
can even be seen in your example above.

Jan

>  
>  
>  LxMounts()
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
