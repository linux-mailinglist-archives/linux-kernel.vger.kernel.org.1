Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4100521A3AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGIP0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgGIP0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:26:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B25C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 08:26:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so1265429pjw.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Io/mcFrQGmKFI/J7y8Kvbnw7Sd2yzklarBYDCcZ/mU4=;
        b=lqOZ9VnoNFqFqWU6dnrvF3ytzvguHdIiMzhTNUwohP1JTvBJUE0fGANEr1kEpsRYaU
         T88hkxoG+egozI5GuJ1u03E5Az1rZYBu4pj8imOnW6/WuJyf4ZhIA83lN49SaML6koNh
         7Jnu5FDNs7JJ/V5DZgH5wY6L3f9qS+8Td+YRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Io/mcFrQGmKFI/J7y8Kvbnw7Sd2yzklarBYDCcZ/mU4=;
        b=U/s2ykRq9SznbGF+q8tW1d5TyzGvrhUG0gchzb9MbtEfEOwh+R3HYU89IJwirv5ja3
         qFaL0hYuEF8B64ZhVcMDb9sNyF3kkhOHdRq46LhRe0iCyin67fsqLPnqNhHReXiISVOg
         OP3sIYRjQVwyDLHD/AYUh3ZwDWX7e25BIPjo3dN7RIeuzXxoXsqCn62yZDYiRntpURHe
         l0BgPo+g3t9mH3BPKmOvnLIP9Tp8hrFLgLO7OktkPeQplUFSJ6VCtFbd4wNmGGl8XSuQ
         Fqc2JKJwhuGNcDxbzbExoJcHiYhupe3s5phBXCoY47cS+Xv65hLCqT2TqTNmZRq53aN+
         9T6w==
X-Gm-Message-State: AOAM533GclLUOYOFIedcZkluxARwYYc+R7lN8wvV5gQHdA6pUezAKMxr
        A/eIJZCT8p63olFHmi4ztJwsrw==
X-Google-Smtp-Source: ABdhPJzMPBypSd95etgDvAlbeBxpHEC0IUibuotoWf73dYLHTKbmK48l2Xgg3Nw9fv2P+eMKHigIsQ==
X-Received: by 2002:a17:902:b687:: with SMTP id c7mr54618732pls.102.1594308413042;
        Thu, 09 Jul 2020 08:26:53 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id g18sm3261173pfk.40.2020.07.09.08.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 08:26:52 -0700 (PDT)
Date:   Thu, 9 Jul 2020 08:26:50 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        gregkh@linuxfoundation.org, georgi.djakov@linaro.org,
        akashast@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        dianders@chromium.org, swboyd@chromium.org
Subject: Re: [PATCH] tty: serial: qcom-geni-serial: Drop the icc bw votes in
 suspend for console
Message-ID: <20200709152650.GI3191083@google.com>
References: <1594287420-24141-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1594287420-24141-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 03:07:00PM +0530, Rajendra Nayak wrote:
> When using the geni-serial as console, its important to be
> able to hit the lowest possible power state in suspend,
> even with no_console_suspend.
> The only thing that prevents it today on platforms like the sc7180
> is the interconnect BW votes, which we certainly don't need when
> the system is in suspend. So in the suspend handler mark them as
> ACTIVE_ONLY (0x3) and on resume switch them back to the ALWAYS tag (0x7)
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Tested-by: Matthias Kaehlcke <mka@chromium.org>
