Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0238722CC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 19:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGXRyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 13:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgGXRyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:54:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8598EC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:54:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 1so5610187pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LlWadNnJdj0hYYYVqCSZw2hjiyDxpJ2Kj8kn/NHt3FY=;
        b=atxoVVvNQ3oTazgRIDpHxSGrFLt9cvtoIBlvch0KQdY3aDyXvLQIdUzTcezi4vTG7R
         p3oklZStvCkO8gbZjqGkGxlAitCYYYinGGGKXpTA/1ZkFvIU2Ri3ri/cv2Fi2+1owHn3
         aDPZiQhkJ2XnheLh3/Pzmn1G0Q2Js7lTuAUNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LlWadNnJdj0hYYYVqCSZw2hjiyDxpJ2Kj8kn/NHt3FY=;
        b=aGjPBB6OT+11HL4I58Vyu2yQqV3fqJMpQ46NYy9vdi4ZAd9VznUAPmM6GOAPv8IFpB
         4HQFZPlG1gJQVYUd0QsiP4NLrQtNiZgsfB5eiyvd9BKuioRq7ljgG8XxFY+tmR/PQ9hA
         12nvCu6Do9Wc8YOcF/DQoGiRd5jZNJT9Kr2jbMmlphxCZIUqWq0mhu5HO4H//86ixznb
         WYY39vCbd375mm3N72vJIvneiTqnIZMIUUg/ZeZW2y4VaZ5PE4WAvWPe6umZ/61ip8ri
         Yu/fCDdfvw9C5KouYDYvnNtc3PARndOZDNWm4s6e4hcCfuG/Frgcl7rO0jP0tZCA6jRw
         7ZOg==
X-Gm-Message-State: AOAM530L1e84Takfa/0/qcL9YrR+22nIsZ6eEtRtRdZibKaf3oCS53pz
        uxPIl9KwxTClkqKuJAZ3hqKa+A==
X-Google-Smtp-Source: ABdhPJwAqrIfdoT4BFkrasAiJFdaIdj3r/Ze/FIypWTH8bIiiBhHfRqSOlNvvGH0vC6qTvZaO894kw==
X-Received: by 2002:a63:e241:: with SMTP id y1mr9814521pgj.410.1595613251093;
        Fri, 24 Jul 2020 10:54:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id my16sm3221207pjb.43.2020.07.24.10.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 10:54:10 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:54:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 39/75] x86/sev-es: Print SEV-ES info into kernel log
Message-ID: <202007241054.B7E226E8@keescook>
References: <20200724160336.5435-1-joro@8bytes.org>
 <20200724160336.5435-40-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724160336.5435-40-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:03:00PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Refactor the message printed to the kernel log which indicates whether
> SEV or SME is active to print a list of enabled encryption features.
> This will scale better in the future when more memory encryption
> features might be added. Also add SEV-ES to the list of features.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
