Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839E91DED1B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 18:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgEVQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 12:21:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:37766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgEVQVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:21:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 03F0DB27C;
        Fri, 22 May 2020 16:21:18 +0000 (UTC)
Date:   Fri, 22 May 2020 18:21:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/6] printk: Collapse shutdown types into a single
 dump reason
Message-ID: <20200522162113.GK3464@linux-b0ei>
References: <20200515184434.8470-1-keescook@chromium.org>
 <20200515184434.8470-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515184434.8470-2-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-05-15 11:44:29, Kees Cook wrote:
> To turn the KMSG_DUMP_* reasons into a more ordered list, collapse
> the redundant KMSG_DUMP_(RESTART|HALT|POWEROFF) reasons into
> KMSG_DUMP_SHUTDOWN. The current users already don't meaningfully
> distinguish between them, so there's no need to, as discussed here:
> https://lore.kernel.org/lkml/CA+CK2bAPv5u1ih5y9t5FUnTyximtFCtDYXJCpuyjOyHNOkRdqw@mail.gmail.com/
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
