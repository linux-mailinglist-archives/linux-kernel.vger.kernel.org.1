Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1222DDB73
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 23:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgLQWa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 17:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732153AbgLQWa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:30:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA0C0611CD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:30:13 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s2so307129plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pf9ckCEVaJ6zRPQluKNLBc+gFVAc92xCjtYHcq1JC/A=;
        b=mric7Hjj4cDYfT8pldW/fafGOVPxVs+mQFbytAiEFHYJTaxQpPs5WGeRJdQr7BzdVX
         ihAg41fvq0zIyvX5aFC2MqMexW25taT4H6J7QvZ5mkEdMop5x6mlkPcFpIqq/IlNbkI0
         0uIDEzpn4n4iOfw61QNDzjOWwaGBAtx2WH5M0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pf9ckCEVaJ6zRPQluKNLBc+gFVAc92xCjtYHcq1JC/A=;
        b=Bh/f5Q28NcZrR+eAeJMMEjNb1YOTlRcxugoHxQYC3yERuKTWaqe9foy6qkhSf4sSEm
         18OquQyxP+IfU6+hTNIzPso9u4Yn89LuYWAhTqZ5HpcdE95RY6xnC5XCGq6q8c3Hg9ge
         zciq03Q1kDrkNYogLSLBB8+SVHrXub3poTB3lqCiIfjGSBM9XSIF9GhYOvcQCTzp0rw8
         udHsRJLfKerz/MUCFGQGkvR6QCgt1T2HqmaOwx3zXFx6iamB9cCL1vjnkTTylVcL1Dl1
         VVLTJzWDhn4+pAlb3KbHg31KePtCG9bOqDaIN3f99vmiH9TxeQnP4dQ8Ext/q2O9u23+
         Qzsw==
X-Gm-Message-State: AOAM533j/sFI06WQ0ChmPej8Ax981bjDVMpedqN9yNJha+jPo9qagqus
        nMtSN1CHWnJFLgqIkoqee47xoA==
X-Google-Smtp-Source: ABdhPJx2cbX0FBjlN0OqPmNj516SIg9lvraV+rd1J5A+Cm3zOrLoueWLJm2ajUoRLZxZZeF3sxFHWA==
X-Received: by 2002:a17:90a:f311:: with SMTP id ca17mr1312552pjb.180.1608244213043;
        Thu, 17 Dec 2020 14:30:13 -0800 (PST)
Received: from google.com ([2620:15c:202:201:8edc:d4ff:fe53:350d])
        by smtp.gmail.com with ESMTPSA id c62sm6779936pfa.116.2020.12.17.14.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 14:30:12 -0800 (PST)
Date:   Thu, 17 Dec 2020 14:30:09 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Youghandhar Chintala <youghand@codeaurora.org>
Cc:     johannes@sipsolutions.net, ath10k@lists.infradead.org,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuabhs@chromium.org,
        dianders@chromium.org, pillair@codeaurora.org
Subject: Re: [PATCH 0/3] mac80211: Trigger disconnect for STA during recovery
Message-ID: <X9vb8TQvjElEtscA@google.com>
References: <20201215172113.5038-1-youghand@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215172113.5038-1-youghand@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 10:51:13PM +0530, Youghandhar Chintala wrote:
> From: Rakesh Pillai <pillair@codeaurora.org>

I meant to mention in my other reply: the threading on this series is
broken (as in, it doesn't exist). It looks like you're using
git-send-email (good!), but somehow it doesn't have any In-Reply-To or
References (bad!). Did you send all your mail in one invocation, or did
you send them as separate git-send-email commands? Anyway, please
investigate what when wrong so you can get this right in the future.

For one, this affects Patchwork's ability to group patch series (not to
mention everybody who uses a decent mail reader, with proper threading).
See for example the lore archive, which only is threading replies to
this cover letter:

https://lore.kernel.org/linux-wireless/20201215172113.5038-1-youghand@codeaurora.org/

Regards,
Brian
