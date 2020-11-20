Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C82D2BB61E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgKTTwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgKTTwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:52:10 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20622C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:52:10 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w14so8879935pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X8uKo4cphvUHXqX5JxQoRlUg2+q0bv7B3NpzE4jNXx4=;
        b=NjicivzP6e7SYMGkEBIyXRQXAuwbm0gtPM2k8GbKG+FXs5uMK6r45ZW9k43d90VPhz
         DEwlvk+hjPwAEmTwtOxx5b+TNVWu4eUMG/3N0D/8FspQpW3NT+b44HH9yfqn1UraPXHu
         F0SjPXkVaYltiU4GPMrXvii7LnjgTXN6SUtys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X8uKo4cphvUHXqX5JxQoRlUg2+q0bv7B3NpzE4jNXx4=;
        b=ILbqAmazH+CrTuFDbKDfN55OayBTxfjLrzY37J7UF9078WSexqaYphvq8reN0k6PtU
         SIRTuiSLUWEYx/91zqRvom+Bw8geDC/pX67avB1DtTcfxbJSUo46wIIjelaXX23obvHO
         svm30JY8m04hjtd+/a1IzSsioXPZmT6qm9dyEirhOBkOzXyAbDNb6kiWqltk7G2C4nJY
         K4Imi9vTY7nMhXhzCCUPtwIj0Osb1Q90eibmwZXr7xkecfW1HK6MQpGmTvKvLJkKVOZJ
         p7mBXFajvJWzpQfFnM5R0t2nElIBCRhKzY7LpT/iJeSuT8mRWP/W0lWIHTfM9Od1lzVg
         InxA==
X-Gm-Message-State: AOAM530FkoPFswyDJhJ0scX4DLhTZ5CRNgrdMg19TK7/4q057gi9hkAU
        xAmZtiUrTf9Ma2BXTuHoOjc3Qw==
X-Google-Smtp-Source: ABdhPJwmhNo/oa0SgoI9bFv2vw35wuYBJ8aIsma7B0R9UgFb9THn90BCMvVwZzJYilwrEanzKZdGvQ==
X-Received: by 2002:a65:56c8:: with SMTP id w8mr18436826pgs.383.1605901929516;
        Fri, 20 Nov 2020 11:52:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5sm2749417pgp.79.2020.11.20.11.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:52:08 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:52:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Francis Laniel <laniel_francis@privacyrequired.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net
Subject: Re: [PATCH v6 0/5] Fortify strscpy()
Message-ID: <202011201150.AE57F56EB@keescook>
References: <20201119164915.10618-1-laniel_francis@privacyrequired.com>
 <20201119173543.8821881942022fc4f39c4c73@linux-foundation.org>
 <5676804.6kI0aEeX2c@machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5676804.6kI0aEeX2c@machine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 10:40:38AM +0100, Francis Laniel wrote:
> Le vendredi 20 novembre 2020, 02:35:43 CET Andrew Morton a écrit :
> > On Thu, 19 Nov 2020 17:49:10 +0100 laniel_francis@privacyrequired.com wrote:
> > > This patch set answers to this issue:
> > > https://github.com/KSPP/linux/issues/46
> > 
> > I fail to understand what this patchset has to do with that
> > one-element-array issue :(
>
> I think I linked another issue totally not related with that one...

This just looks like a typo. The URL should be:
https://github.com/KSPP/linux/issues/96

-- 
Kees Cook
