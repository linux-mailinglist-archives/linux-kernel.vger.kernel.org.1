Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2022EA827
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbhAEKCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:02:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbhAEKCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:02:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D9122482;
        Tue,  5 Jan 2021 10:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609840920;
        bh=+BH9oMfnMwOG5EZl9H1+6lOwFuch1xY//KaHeSIcHxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jtIRoEUSNr8PI9gk6in85FaRXiOLg1Z4GEbrvetvCT1/FjbULVN4yTJKSR3RH3V1t
         Ex7yhlvs7zbkVpwEqVldH2G5eN1kLMH37FW5nz6Sw4qWgWLzS46CGl72ve8ipGgOoV
         bp4AF+KCgdWbsp0Yzq+yNqfcoGEVxSlvP2tD2rvfjNIbI3r/7zQ2Z2KFjzhwb5xpjG
         JoHRndZN7GZMq07HWYHu1Gh/xtvHw+BhI6n/ITtrm6QW98k6GT6stttjT7vkfO7oEC
         et3TD0RaunxznUJqhv/ml1PmQ5b5YlXbkLoQaxksPob5sVyyqQ7+wTK91MEkTO/XOV
         VYlMUNj7Fhxtw==
Date:   Tue, 5 Jan 2021 19:01:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, shuah@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Disable multiple_kprobes test on
 powerpc
Message-Id: <20210105190156.ada6ce0d46d7eada18b9ad76@kernel.org>
In-Reply-To: <20210105065730.2634785-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20210105065730.2634785-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Jan 2021 12:27:30 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Not all symbols are blacklisted on powerpc. Disable multiple_kprobes
> test until that is sorted, so that rest of ftrace and kprobe selftests
> can be run.

This looks good to me, but could you try to find the functions
which should be blocked from kprobes?
(Usually, the function which are involved in the sw-breakpoint
 handling, including locks etc.)

Thank you,

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  .../testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> index 312d237800969e..41503c32f53eed 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/multiple_kprobes.tc
> @@ -7,7 +7,7 @@
>  # Currently HAVE_KPROBES_ON_FTRACE defined on x86 and powerpc64le
>  case `uname -m` in
>    x86_64|i[3456]86) OFFS=5;;
> -  ppc64le) OFFS=8;;
> +  ppc*) exit_unsupported;;
>    *) OFFS=0;;
>  esac
>  
> 
> base-commit: 36bbbd0e234d817938bdc52121a0f5473b3e58f5
> -- 
> 2.25.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
