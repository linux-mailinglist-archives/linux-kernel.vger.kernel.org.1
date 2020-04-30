Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF001C0325
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 18:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgD3QwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 12:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbgD3QwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:52:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFE0C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:52:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so2683948wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K97avfoeCpwqqRxczE/kgPhFRPB8stz3Bwyv+/AM2T8=;
        b=c7iGYC6aTaq/bUXK/PKUTdBfsgEtPpXBsoGt1XDiXh2TmNu0ggeTc1w2hEhZmS9EE3
         2v4t3dVxrm2Kz/i74Xpsksg1ikalHbDQoUUp630dSotrtru18+Exxr3SuTDRo49dD3xK
         INnK9nalt5lYXL6xHFUDY7zC4IJP6L0EiO6PolTRFUHZl/KIp8TKnllJMw+saaIP5zbJ
         lq+LoOy3MllKxIMjHSnEPfx1mZHlDXSJlRIjafFazhwxhCRdWC/s+sLmH2Yl11x6K1/u
         IHBiXgiznmndzRcrjMHp6ckVwkTOJnoZQB7krYp1RgW4VzUmaAS6z8p8+DMDCL3ZmYjS
         HK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K97avfoeCpwqqRxczE/kgPhFRPB8stz3Bwyv+/AM2T8=;
        b=RBYHur6p7mKOXYJRMnCypi3TncYMGS9lQxlOMBaNcLyZLsOn+fa8jSOwMMBX/e/DQI
         8eBImYOpXFvH556Tmc2fpR7hzjr06ofssdl8bJ4ZPd0zBFCzhCihLkGEFMFmtsWhnrtk
         d12PKFMaQzs+hui0m7zjCasULVowzjRPvXkbDN2QTk3lBLkfrL9uzaDRCh62vGl+mrdI
         qzK0ucvH2uHbGRDVTfd2Ir83GX/aQ+08ol8FeoiFO6WLUoKIKuk5O+ebPy2tyb3P1mNZ
         gbumvc92+BcOM2fK8n85Xgizczo13thTodK1/BCvxEdwWEDoxX+n0nw58LjJi8ayV32k
         6WkQ==
X-Gm-Message-State: AGi0PuYt5SMlQbW86KUrdGaxgZzR8FM0ZmiTy4XMdrjY8DfC1hysBfoC
        nNoPc1v0Vc+mXJ76BTb68PsLfw==
X-Google-Smtp-Source: APiQypJPfxiBLqtR94rFFnxprsJ8BntAXmdItGqwpn9asW3IBEl2ZJjz+8gJBtPazBl+AkaL7bkWpA==
X-Received: by 2002:a1c:8106:: with SMTP id c6mr3961982wmd.88.1588265530909;
        Thu, 30 Apr 2020 09:52:10 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z10sm410920wrg.69.2020.04.30.09.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 09:52:10 -0700 (PDT)
Date:   Thu, 30 Apr 2020 17:52:08 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        agross@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        catalin.marinas@arm.com, linux-serial@vger.kernel.org,
        sumit.garg@linaro.org, corbet@lwn.net, mingo@redhat.com,
        will@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        frowand.list@gmail.com, bp@alien8.de, bjorn.andersson@linaro.org,
        jslaby@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/11] kgdb: Prevent infinite recursive entries to the
 debugger
Message-ID: <20200430165208.7btqnsygf7kn3cso@holly.lan>
References: <20200428211351.85055-1-dianders@chromium.org>
 <20200428141218.v3.6.I89de39f68736c9de610e6f241e68d8dbc44bc266@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428141218.v3.6.I89de39f68736c9de610e6f241e68d8dbc44bc266@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:13:46PM -0700, Douglas Anderson wrote:
> If we detect that we recursively entered the debugger we should hack
> our I/O ops to NULL so that the panic() in the next line won't
> actually cause another recursion into the debugger.  The first line of
> kgdb_panic() will check this and return.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
