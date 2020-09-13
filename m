Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC57267F0E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 11:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgIMJ5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 05:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgIMJ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 05:57:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAEEC061573;
        Sun, 13 Sep 2020 02:57:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so19181970eja.3;
        Sun, 13 Sep 2020 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Gbv3T8O0xJ0qCU1qNd8Of6YIK0SU5dp95SQ3PtDWaO0=;
        b=Wy38gqJUeXaggqjLqI+pGJq8kU7x1t7zpokB4YzSRMZUvWco/F1t5xd0A6p8+/Hg5J
         kD5XAcuBo3dOejieIZrIzgITWoB0bpTnOPJKAD57voEwXtlgLFTVXG0MgwIh5womWalT
         PmN5m9gWb5QDscoT/7/9HnGnHUtqOsUHXVpvSfnO7MDrc1SFN4sYjTRPiBEVUti7+r5V
         fFHvKVyVuqWhZH9CKUIteCsG0cByIERnHKOqxrYjtclMorDRtZ01MVdgUq9bYnH5g5EE
         eyegwOWnCbZHhxIZzhE7ypQchJhlqVhM7OLjLBT+gP/hbgCQkoI9y2zIGRL4rw+qaMhR
         cLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Gbv3T8O0xJ0qCU1qNd8Of6YIK0SU5dp95SQ3PtDWaO0=;
        b=TSgOdrIUGTUbs5SXduFAZvMLS0g2LXw8XuysNT1TeXmd8fGN2+RTQIwdP6zAr2H0cL
         Sg1V6Tb0GgHo4aUmuHw4wqx03IMjIh9mwJw4aayBUeMdEsjyX0S1SQcw18Dv0oT3BIBC
         uTYwjeSD1ESKBn+Qu7mhwnWJVjrEAF1QqekAeY5HulDqPcx1zPGQAEuU5BRqQA/AparM
         eKCbppO6t74t69GFdAtWHghc25oNcQ5rvbkzGjQZOnu3in3m3Uf15LwjA/UJYuLTuBjt
         7/xIEg95NA9fivdhbd5fhzIgfwouszkKyeMJRnWm7iKx42GbXf+X1AqpTVoEF8e5N/Pc
         UYSA==
X-Gm-Message-State: AOAM531ZP9XoR8ftwOgMkivQY392B7BeFRZ3UsUqXA2KkwdgaoXWo9cL
        /KcfIpfF082tH+Z7sT9kuB68Bu28MF2cm7cS
X-Google-Smtp-Source: ABdhPJzOcn6Rwbu13exfp1gYWilPlEYFx3hJ/rPNokplQtCfPNYNOKopygMfJTFKWFoYi5bB4a2BHQ==
X-Received: by 2002:a17:906:facb:: with SMTP id lu11mr10087536ejb.249.1599991028362;
        Sun, 13 Sep 2020 02:57:08 -0700 (PDT)
Received: from felia ([2001:16b8:2dcc:7f00:79af:10ed:f757:91c8])
        by smtp.gmail.com with ESMTPSA id w1sm6408015eds.18.2020.09.13.02.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 02:57:07 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Sun, 13 Sep 2020 11:57:01 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
cc:     Joel Stanley <joel@jms.id.au>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-aspeed@lists.ozlabs.org,
        dri-devel@lists.freedesktop.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: make linux-aspeed list remarks consistent
In-Reply-To: <20200912183334.22683-1-lukas.bulwahn@gmail.com>
Message-ID: <alpine.DEB.2.21.2009131156090.6163@felia>
References: <20200912183334.22683-1-lukas.bulwahn@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 12 Sep 2020, Lukas Bulwahn wrote:

> Commit f15a3ea80391 ("MAINTAINERS: Add ASPEED BMC GFX DRM driver entry")
> does not mention that linux-aspeed@lists.ozlabs.org is moderated for
> non-subscribers, but the other three entries for
> linux-aspeed@lists.ozlabs.org do.
> 
> By 'majority vote' among entries, let us assume it was just missed here and
> adjust it to be consistent with others.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on master and next-20200911
> 
> Joel, please ack.
> David, Daniel, please pick this minor non-urgent clean-up patch.
> 
> This patch submission will also show me if linux-aspeed is moderated or
> not. I have not subscribed to linux-aspeed and if it shows up quickly in
> the archive, the list is probably not moderated; and if it takes longer,
> it is moderated, and hence, validating the patch.
>

I did quickly get back an moderation email that my email is being held 
back. So, that response validates my patch.

Lukas
