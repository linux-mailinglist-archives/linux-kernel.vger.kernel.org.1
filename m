Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDF32A71CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 00:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbgKDXbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 18:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgKDXbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 18:31:47 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D715DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 15:31:45 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 12so150215qkl.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 15:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hkU6HJZvR4akq9aNkA/6+X7X6u9jB+w9l/AGXazTlXs=;
        b=cO23P3Gu0OtXCB60SEdnjT22M2jYGUl8PSH9Yp3YLIQcEczhcp3zA2VS0kfoKfZYSV
         cEV5A5Fz0bmmHMIAFwvnrGads7v3MwnfCN8hpnaZzoqNC9BlIZ76psBr4IX+PoUOZ/JJ
         aiDR+vTSzk99yTR3W1v65xO1lWxTwyrSRTTDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hkU6HJZvR4akq9aNkA/6+X7X6u9jB+w9l/AGXazTlXs=;
        b=TYgrgqNvF4uQIyX8pB3QTclVBzyontbj5fLEeZoVnhGWwGL94ScsV28w3yuIVHXZXG
         17hXK758obHd4h6aEqq/Y8IZKnfOD53u7/jj2iI3/+bSBbMk46tLpWS/vx/4dgTWp3T2
         QFaqCFQ5c9BAdjMd3Y8dowmzMsVS5JNMY5+0vVPeR2wwnsjXgwcDvvF5kMxAPOSiC+XU
         QEu/7q02zNpQcGpoZHrDXUfKhHztXMhAjcxYR1ypTVp6POpqJ5k2zXw4sTpgnnLFmtw3
         7HgpxV1goBJ4CLjRhcfHDvNR1SU26cO4WKuTJCeZqPiaSgbtDG30n3qUx+ilcuwYRyIF
         Us8w==
X-Gm-Message-State: AOAM531D+29gnsrvgHsn1O5sKN4b5snm/ZUvvPR76qccvA/A95rBHP1k
        boYPGe4MiP/1g+Nc7YEgmJq0qg==
X-Google-Smtp-Source: ABdhPJxrZpD3cTkdkaAjY1xMGH0IqLZL5MV/GQMjLK6+5ITe9WhnC3Gqu0id7QiuGaPrfp3rILb/0A==
X-Received: by 2002:ae9:de45:: with SMTP id s66mr596876qkf.281.1604532705003;
        Wed, 04 Nov 2020 15:31:45 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 82sm571791qkg.103.2020.11.04.15.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:31:44 -0800 (PST)
Date:   Wed, 4 Nov 2020 18:31:43 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Anand K. Mistry" <amistry@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Anthony Steinhauser <asteinhauser@google.com>,
        tglx@linutronix.de, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/speculation: Allow IBPB to be conditionally
 enabled on CPUs with always-on STIBP
Message-ID: <20201104233143.GA2496945@google.com>
References: <20201029065133.3027749-1-amistry@google.com>
 <20201029175120.1.Ifd7243cd3e2c2206a893ad0a5b9a4f19549e22c6@changeid>
 <839fad53-4377-592a-a0da-2cf18b5c6027@amd.com>
 <CAATStaOTMrdserLepxkSdFErrjhMKyvd_g_GNBqOo_4p932ikw@mail.gmail.com>
 <20201103105757.GC6310@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103105757.GC6310@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 11:57:57AM +0100, Borislav Petkov wrote:
> On Mon, Nov 02, 2020 at 11:02:10AM +1100, Anand K. Mistry wrote:
> > > I like the idea of passing in the mode you want to check, but it appears
> > > they are never used independently. The ibpb and stibp modes are always
> > > checked together in one of the if statements below, so you could make this
> > > a function that checks both modes and just have a single call. I'll leave
> > > that up to the maintainers to see what is preferred.
> > 
> > I can see both sides to this. Personally, I think I prefer it as-is
> > since I think it improves readability a bit by making the conditions
> > less complicated whilst not hiding too many details. I'll wait to see
> > what others say before changing this one.
> 
> Yes, but if you make it a single function with a descriptive name, you'd
> make the call sites even more readable:
> 
> 	if (!is_spec_ib_conditional(..))
> 		bla;
> 
> or
> 
> 	if (!is_spec_ib_user_controlled(..))
> 		blu;
> 
> and that function should simply check both spectre_v2_user_ibpb *and*
> spectre_v2_user_stibp in one go.
> 
> Why should we do that?
> 
> Exactly because you both got your brains twisted just from looking at
> this. Because this mitigation crap is such an ugly and complex maze that
> we would take even the smallest simplification any day of the week!
> 
> Welcome to my life since meltdown. Brain twist feels good, doesn't it?
> 
> :-)))

I hate the maze too. In theory we can get rid of STIBP if/when
core-scheduling is enabled because the cross-CPU branch predictor poisioning
would not be possible. Maybe that will simplify the maze a bit.

thanks,

 - Joel

