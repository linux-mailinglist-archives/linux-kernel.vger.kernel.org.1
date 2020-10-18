Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80714291FB0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 22:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgJRUHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 16:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbgJRUHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 16:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603051673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NTLZYWawMA/L7zMDVfD3OfVMnCwMIaw3VHURN6LV+Y0=;
        b=KeiQwrW9sPfr+vR6uMFXkyS2kaqOocIRRR+FWQlSwyfTkQXxjiPahAzVW1ddnTIJ+gsEiG
        7JlOsTK0WYxPs0HsZtFCA4ptTn3Ti7MJM5yMW5puegDD8Nv8p5F43mFpt6c88Q4nYR7dIF
        uDfZmDlKk4T9UueSRtetz4GmOrcJ1Ww=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-z5BxICbVO-W4QO6264HbYA-1; Sun, 18 Oct 2020 16:07:51 -0400
X-MC-Unique: z5BxICbVO-W4QO6264HbYA-1
Received: by mail-qt1-f198.google.com with SMTP id i39so5042666qtb.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 13:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NTLZYWawMA/L7zMDVfD3OfVMnCwMIaw3VHURN6LV+Y0=;
        b=Z0VHZuqLOlnPDAyCBcFlsyocRVz4CPftSHA8XOZGDBXft3rEsQ8cVFwBwb1fWaRN40
         0NJsN2uQ8NRSNUZDIgpQaIZyNq0/+aKTh++milpG+Mcs0c/qHspJgRbJeHHngxV1rp4I
         O68BS69xrwJ4mxaBWhQQp7jGob18TyPUHBXwgbIbpq1/noZ6H34fixMHGln+ddQlG0qe
         982sX0J3CcWjPBAO1MeyGfc9CqQP96sI8Bjta/3N45McpNPKombatXC7FpnCg3bBfRDE
         Dih5fsDrThIMJi/4t5MnpWTZ9VzQcPBGDwqYqSqFkepV2Cc+bLWIZYSlgvNdR46z49Bo
         JIzA==
X-Gm-Message-State: AOAM530J3Dxjs8B31976NpoDPPSAYq5SKgK7AqGPirNo8vS/L5MZy5mw
        zW+SSJsXqfMRyufj97l3zUwzKJV9ly/hyraMefcRd6U0JOu8gRSmDlqKq/2aeeeIrCDJF8y4YR1
        S5qBMh6GqFX2tQTJbOqyCDDOi
X-Received: by 2002:a05:620a:2018:: with SMTP id c24mr13315174qka.154.1603051670700;
        Sun, 18 Oct 2020 13:07:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOPFqVFv2ElM0J+6h4M5OMFvrz9WjHO0/gGrsguFVm71lDcwnpUchKmvulX5ZULsK/1q+uCQ==
X-Received: by 2002:a05:620a:2018:: with SMTP id c24mr13315160qka.154.1603051670423;
        Sun, 18 Oct 2020 13:07:50 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 29sm3462782qks.28.2020.10.18.13.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 13:07:49 -0700 (PDT)
Subject: Re: [PATCH] checkpatch: Allow --fix removal of unnecessary break
 statements
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, linux-kernel@vger.kernel.org,
        cocci <cocci@systeme.lip6.fr>
References: <20201017160928.12698-1-trix@redhat.com>
 <f530b7aeecbbf9654b4540cfa20023a4c2a11889.camel@perches.com>
 <alpine.DEB.2.22.394.2010172016370.9440@hadrien>
 <dfe24da760056e31d90ff639b47c494263b5f4a7.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a15ada1f-9bad-612e-e841-934bff088f38@redhat.com>
Date:   Sun, 18 Oct 2020 13:07:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <dfe24da760056e31d90ff639b47c494263b5f4a7.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I like!

On 10/18/20 12:49 PM, Joe Perches wrote:
> switch/case use of break after a return or goto is unnecessary.
>
> There is an existing warning for these uses, so add a --fix option too.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> For today's next, this would remove ~300 instances like:
>
> 	case FOO:
> 		return bar;
> 		break;
> or
> 	case FOO:
> 		goto bar;
> 		break;
>
>  scripts/checkpatch.pl | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fab38b493cef..22263b278e87 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3678,8 +3678,11 @@ sub process {
>  		if ($sline =~ /^\+([\t]+)break\s*;\s*$/) {
>  			my $tabs = $1;
>  			if ($prevline =~ /^\+$tabs(?:goto|return)\b/) {

could add a '|break' here to catch the couple

break;

break;

Reviewed-by: Tom Rix <trix@redhat.com>

> -				WARN("UNNECESSARY_BREAK",
> -				     "break is not useful after a goto or return\n" . $hereprev);
> +				if (WARN("UNNECESSARY_BREAK",
> +					 "break is not useful after a goto or return\n" . $hereprev) &&
> +				    $fix) {
> +					fix_delete_line($fixlinenr, $rawline);
> +				}
>  			}
>  		}
>  
>
>

