Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF702D1943
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgLGTQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLGTQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:16:47 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF720C06138C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 11:15:38 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so11040389pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 11:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hd/sLpJL9/orp2QRdvfsEwBJETO+NpWkNY62GGj384A=;
        b=lsWZtQ/YzHfWOTN1hNWDoxBL6yb9E7Rpf38w6PvlU3Qykptwa3+OgDqcwO6N2c1LTt
         Fn6qjIljswp3e2Lg3R8XPJTYOXXmt5do8vptgFJBBiwwmiFKY/F9LrfmW8M4iBmQSnte
         aX5iHACjs1T7+ScTRiNTNxmkEvClnALofwKS6/+tP2gzg5zoBntColSoTaapBzMZ7uC6
         Nhdi/t9HLWqKnAJu5deteI/0MQCMX0on1maJoyyFu46rHkTn4pFUz8PXTysiolcNi5ka
         fnQYjPnFVJpYtV6pTkmjEVP2L2KmUpQWwTvT7TYBbsVqB7FpldxA0jn5Ef9lx/rn2x2X
         khTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hd/sLpJL9/orp2QRdvfsEwBJETO+NpWkNY62GGj384A=;
        b=gwzNRTYdjLmFXC7PxpoBK1XumFBUNGskM9LV+A+071eQZhUufh+AT0Z6xe5CO427XL
         SF+e8jiIO8stUz88uGxeOe0LvkXhoNGIowuwEetxGKW5mrs5Fs4mkh2qnui4znNxe5GI
         CzVi0+LUNHNGQd6UdUljLMFQkIdegyUt2QcT0ktFC9qn6wv3mMKht0ICAj8ZUybO69aX
         fPev510+VSe3perG5oTWUeNr6FfgBD0SIBMwX2vdkYSMgM1mSUGJ+jU6SzdZ9FkH39FU
         Ft6Azn/risN7X8vqo17Rj2W+Nq9MotnN71/cpbAj1kJTvs6azjEpQ4+/WxGBdtZrg6Sj
         fKCQ==
X-Gm-Message-State: AOAM532coh0L9IlKxe0OUszhe5qxXkzjpM58gsEJhoqgmN5buUL+7yX1
        LKUXp2TPqAY08ZLPsB5n6HR1tw==
X-Google-Smtp-Source: ABdhPJxeQBH22FZPDq92hf9dbxsnKr13iIoM3ezkzxjDbU3rE/3cWTrKrGp93fsltKkE32NgHnv9/A==
X-Received: by 2002:a17:902:830a:b029:da:df3b:459a with SMTP id bd10-20020a170902830ab02900dadf3b459amr12240972plb.75.1607368538498;
        Mon, 07 Dec 2020 11:15:38 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id f7sm14919307pfe.30.2020.12.07.11.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:15:37 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH v4 0/7] arm64: dts: meson: add more GX soundcards
Date:   Mon,  7 Dec 2020 11:15:33 -0800
Message-Id: <160736852893.39684.11773180672658935633.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201203060023.9454-1-christianshewitt@gmail.com>
References: <20201203060023.9454-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 06:00:16 +0000, Christian Hewitt wrote:
> This series adds basic support for LPCM audio over HDMI and S/PDIF
> to GXBB/GXL/GXM devices that I own and have tested with. Audio can
> be extended in the future (some devices have DACs and headphone
> hardware to connect) but this gets the basics working.
> 
> Changes from v3
> - Drop includes tidying in patches 2,3
> - Add Jerome's acks
> 
> [...]

Applied, thanks!

[1/7] arm64: dts: meson: add audio playback to a95x
      commit: ec78dc8964bbc68d76d0e9b132379bc3f22c72a6
[2/7] arm64: dts: meson: add audio playback to khadas-vim
      commit: 4e0649f4957436cbce20ffc26239fdbe19638444
[3/7] arm64: dts: meson: add audio playback to khadas-vim2
      commit: 0157e1a63c7685dfeee4e7cfd22635ebf104f64f
[4/7] arm64: dts: meson: add audio playback to nanopi-k2
      commit: 6a74f78c34e7503e35da724cdc555f26ea8d1cd1
[5/7] arm64: dts: meson: add audio playback to odroid-c2
      commit: ba414bc5484873bb157e63ba8684d59e27feaeb2
[6/7] arm64: dts: meson: add audio playback to wetek-hub
      commit: e0d9e6eead35be9842aae14f424f2d2ab0be0678
[7/7] arm64: dts: meson: add audio playback to wetek-play2
      commit: 5e3ee48ea072a6fd2c46c552d013e047dc54d1c6

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
