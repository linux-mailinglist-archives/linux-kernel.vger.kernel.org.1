Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8013429286C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbgJSNmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 09:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgJSNmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 09:42:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0302223C;
        Mon, 19 Oct 2020 13:42:37 +0000 (UTC)
Date:   Mon, 19 Oct 2020 09:42:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH] libtraceevent: install html files
Message-ID: <20201019094234.0b36bb61@gandalf.local.home>
In-Reply-To: <20201018211912.17541-1-sudipm.mukherjee@gmail.com>
References: <20201018211912.17541-1-sudipm.mukherjee@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Oct 2020 22:19:12 +0100
Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:

> Only the man pages were installed using "make install". Add rules to
> install html files also.
> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
>  tools/lib/traceevent/Documentation/Makefile | 14 ++++++++++++--

Thanks Sudip,

Although, to apply it to the libtraceevent.git repo, I had to strip off the
"tools/lib/traceevent/" from the file paths.

-- Steve


>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/traceevent/Documentation/Makefile b/tools/lib/traceevent/Documentation/Makefile
> index aa72ab96c3c1..dd3d62b17140 100644
> --- a/tools/lib/traceevent/Documentation/Makefile
> +++ b/tools/lib/traceevent/Documentation/Makefile
> @@ -147,7 +147,7 @@ html: $(MAN_HTML)
>  
>  $(MAN_HTML) $(DOC_MAN3): asciidoc.conf
>  
> -install: install-man
> +install: install-man install-html
>  
>  check-man-tools:
>  ifdef missing_tools
> @@ -161,12 +161,22 @@ do-install-man: man
>  
>  install-man: check-man-tools man do-install-man
>  
> -uninstall: uninstall-man
> +do-install-html: html
> +	$(call QUIET_INSTALL, Documentation-html) \
> +		$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir); \
> +		$(INSTALL) -m 644 $(OUTPUT)*.html $(DESTDIR)$(htmldir);
> +
> +install-html: check-man-tools html do-install-html
> +
> +uninstall: uninstall-man uninstall-html
>  
>  uninstall-man:
>  	$(call QUIET_UNINST, Documentation-man) \
>  		$(Q)$(RM) $(addprefix $(DESTDIR)$(man3dir)/,$(DOC_MAN3))
>  
> +uninstall-html:
> +	$(call QUIET_UNINST, Documentation-html) \
> +		$(Q)$(RM) $(addprefix $(DESTDIR)$(htmldir)/,$(MAN_HTML))
>  
>  ifdef missing_tools
>    DO_INSTALL_MAN = $(warning Please install $(missing_tools) to have the man pages installed)

