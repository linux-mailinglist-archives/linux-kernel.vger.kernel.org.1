Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A00260DE4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 10:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgIHIqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 04:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730157AbgIHIqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:46:35 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7F6C061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:46:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so18189904wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zxSReaeKsWNMqXHUrN/wepLZJeaGHtV4Xq/Uiup0Lq0=;
        b=cr10Cch9Nj+ChkzYu7awIXU7u2p6g+HckAnw0AN03Ju+nc4hZTJtgmLXQnnssbVsA4
         JyplKDgV9jP7cqGeWflqT3QoH1Q6HGTr3zOCTB6f6bPRW0+WDpUe4RsIN/aiwq/eFpEY
         MSNz+OBZiVwLOO/M8167ynnFuRcd049fa650TjugZQ7OsntRCb3mMm84Mcz0epk+5oNM
         7X/q3mUJDh5Pw2OuVzr1rvLrvpWers2I61YhPiRIF43Lqqg3ebYawDwdSsR1mXvTMrzv
         WbTJRcAz6L+88F8cL/ZFpH3pYQE7Ykt66Z75OGXAUhEOLXM04t5OPaHzEuH+oHNlXEKW
         5JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zxSReaeKsWNMqXHUrN/wepLZJeaGHtV4Xq/Uiup0Lq0=;
        b=RjVwJsvdV9qUvipxNkZOpwfiEGMR1T0JBNFX5EV8PsiWxprwQFhb1gDXvTgqE9yOcr
         ShHPKUAnkFW9/5K78a+30H1tPFbFjRzVgaR3yx9JeXHRHry52prqYEYSDbnZ+HPh9oVr
         BL+8+LDkV/7ZO8c33ZZKSfWGoTMdUZ6lJoD9JhUDEx0PaAP6dVY85l4LLDtOc5ccOWen
         HdWSx26/M4wEa4AZmAKL7r2eXmYdP/vIxSr15SAbPsqAWWhB/+tUDpBqKrMrUUNYmo9w
         dLhejXKoOZakHk0W1vaCk5OZ4UPkYyL7n9lmxumV6MvU7znOVPCSgHRU9uIBJy7YO4m3
         YgQA==
X-Gm-Message-State: AOAM533eJqiwr6oTioV5OKDSoMOQNJpYhU9SfZu+XCvKstHyJMnJyDlP
        OouaCkb1IZjDsVAm25z/aijcfA==
X-Google-Smtp-Source: ABdhPJxZbaSYb25L3hU2Pkh9dQuXeFyxa4dIIIyjnSG68UCmKVekbt2t/B5nwBHgLaYIh1vOZBLLLg==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr6416895wrx.140.1599554792285;
        Tue, 08 Sep 2020 01:46:32 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id 9sm11623485wmf.7.2020.09.08.01.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:46:31 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:46:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/32] Set 2: Rid W=1 warnings in Wireless
Message-ID: <20200908084629.GI4400@dell>
References: <20200821071644.109970-1-lee.jones@linaro.org>
 <87o8mp6epv.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8mp6epv.fsf@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Sep 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> >
> > There are quite a few W=1 warnings in the Wireless.  My plan
> > is to work through all of them over the next few weeks.
> > Hopefully it won't be too long before drivers/net/wireless
> > builds clean with W=1 enabled.
> 
> BTW, now the patches are in random order and it's quite annoying to
> review when there's no logic. Grouping them by the driver would be a lot
> more pleasent for reviewers.

My script makes a best effort attempt to group changes by file.  It
takes the first warning presented by the compiler then greps the
output for all issues pertaining to that file.  I then split the patch
by issue (i.e. different patches for; kernel-doc, unused variables,
bracketing etc).

One issue you might be seeing is the potential for one fixed issue to
cause another i.e. when one unused variable is removed which was the
only user of another, leading to a subsequent fix of the newly unused
variable.

Other than that, I'm not sure why they would end up out of order.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
