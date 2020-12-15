Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB6D2DB658
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgLOWFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgLOWE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:04:59 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE22C061793
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 14:04:18 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id k65so5863413pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 14:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=syHwQU1H+sMHPHpfstRHv+eAt3C5whQf9ZSlLwH7JxU=;
        b=oX11CLnoAq++KQ7G4SymkguARAazqb67nDAy2gjvtAYi9uTGod9FcokqnGEAwfZSDN
         W9fgOp5cW/a+8cMp9SHnVyIzL+f0QxN//Qc9+/AHft7zEmaJq2+rr44B0dn82sK/nJsV
         pm0WbkmbWuWvIJzEC5DVJyrQzKKHno9f6oaTGMGOXka/cbsXSQhJNZ+tbT7QgIbnCD83
         JbASkxLIHrGlMisZXjG3FA9qBWJ+eV1VQYSTueGZGXuxso6fyl33LbkLtOhSes2bOosz
         uXS2bb6YRQ6HOUcqjLVtrPMhLiCBldRo+7FiYiHYirObKkRJXQhOUTOpVD7hEEm6nDN1
         IHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=syHwQU1H+sMHPHpfstRHv+eAt3C5whQf9ZSlLwH7JxU=;
        b=f91PsKZMYvnp8LiokEU289qGN6ExLNNQOq9AS/FK3Kd3ybbCpB+QtGkmCLsh6/wxxH
         NLRqUzl9nOd0IlJYCpBJbeTg4jf+FSyo4MRuTMLBd5m+xjfPdJYW1F/xTbrJY63deNWG
         C9SYWc/0Ut1MVipP4IHoU9j1CbtiDHWezJBYXOfRCzaUR49m7yPf3Wrd32eGJzwIQRyE
         ITsPfx+jqR34Z/aE5G2Geb05V5V6ySf9SDn834ocYkqR0OpAEOgymOtu4UrCHvGLLI9l
         M3T05PB6a0p+m2WqB45TSB88VFaH4uY2I/ruIAKTwcMfb4lgqsmxWfj+o/pFm8sNMbKI
         eQAw==
X-Gm-Message-State: AOAM530C1/jEPgI+kHQvmW/I1PNJY4RwxonFAaNn6v7lDBOZe7McI7gp
        zE6XAWvU2ix/Z1Nta2yXwvYTuw==
X-Google-Smtp-Source: ABdhPJwVg6fGCwFbSZdMD5V+YrVt3Ug2/gYblGulFInW2CamLlD603kpf2piGiJVLBLbRPFEF8KNVg==
X-Received: by 2002:aa7:9d81:0:b029:19d:ca64:3c62 with SMTP id f1-20020aa79d810000b029019dca643c62mr29969751pfq.16.1608069857667;
        Tue, 15 Dec 2020 14:04:17 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id y1sm92868pff.17.2020.12.15.14.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 14:04:16 -0800 (PST)
Date:   Tue, 15 Dec 2020 14:04:10 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/sgx: Synchronize encl->srcu in sgx_encl_release().
Message-ID: <X9ky2n7VcGEGmODx@google.com>
References: <20201211113230.28909-1-jarkko@kernel.org>
 <X9e2jOWz1hfXVpQ5@google.com>
 <20201215055556.GA28278@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215055556.GA28278@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020, Jarkko Sakkinen wrote:
> On Mon, Dec 14, 2020 at 11:01:32AM -0800, Sean Christopherson wrote:
> > Haitao reported the bug, and for all intents and purposes provided the fix.  I
> > just did the analysis to verify that there was a legitimate bug and that the
> > synchronization in sgx_encl_release() was indeed necessary.
> 
> Good and valid point. The way I see it, the tags should be:
> 
> Reported-by: Haitao Huang <haitao.huang@linux.intel.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> 
> Haitao pointed out the bug but from your analysis I could resolve that
> this is the fix to implement, and was able to write the long
> description for the commit.
> 
> Does this make sense to you?

Yep, works for me.
