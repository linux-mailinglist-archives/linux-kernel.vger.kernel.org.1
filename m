Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0782BB4F0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbgKTTMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbgKTTMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:12:22 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF3C061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:12:20 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q5so8784662pfk.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSI6Hxh+VGHB4fhlPl5YbxM+ykFtkRO9Um5a1XP/b8k=;
        b=fiqD0N+EBqOKVErzzLpV4bPF1fE3+I8bj1UxfCHzf+jxKi2FyR3ukjSq/Cr1nHP+qu
         KcHv4/L2yeq28sT0z44zGo285lcYYILwn6A0MOZjDZmfzK0Xt3aPtg6iFGpSisg2hLbo
         vIfIZblp9FAZiEI6w4/B3OvshJQ7xBPICOeDHOW5pcZaISvBJStpOJAUgQrCMkNGuIBX
         PI2Fs53GtpS6+WiiTdSZuXkhabqyo1ck0kSsjaGTKTWWBoyDgn+SvAfe48HRSGULGIyH
         N+UMBIlOiPG+rQyvWuP9y7DbhRZt5AZpTojOeR1skRvcY4LsR8T3yMeY/50VWDjtvN2E
         pGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSI6Hxh+VGHB4fhlPl5YbxM+ykFtkRO9Um5a1XP/b8k=;
        b=FfCzVeNn6sONx6oqk72SiqsszbthJeoLgYMKHqY0ckc+Wwo62cr76BPy+lO0RXPA9b
         nw+1KekDKpSw9gnRe69oZRCkTH0rlJ+uX4I3m/gY4/K7N2vAhov4ca+BLh874/iZ9ibm
         pFjQTKmpoexOYVHJs16rXnQfGPB8VIqk4+9/62kQ24sEcjgtXl97R2ECxGivo0FuytDL
         EzpjtDLpNCfQtAosmsBRVh8cYhS42qgXqV2u6WZjPV+bBNIu3dZjw7MHASy9zg55IQKC
         heaCqtMnyscxlazHALGp+BKnpxW+FNGY6mBmoDOPmwtQsOjo+1F3EjkPADhi9sC9IKBO
         wImQ==
X-Gm-Message-State: AOAM532LudRkPLR2iFIZRQI+KsZGRyNq0QzRUtr9VoP/UNi4dNgw0/pp
        TtsGtwxGXbKlSZeYS42Z8vZ5dA==
X-Google-Smtp-Source: ABdhPJxFoeHhZywzkXWoTbSzWIgVy74o7t/ThSjCrakBbElNmKQW1LKLaPXh06bYW6FDvfuO8COE0g==
X-Received: by 2002:a17:90a:8b8c:: with SMTP id z12mr11473452pjn.233.1605899540131;
        Fri, 20 Nov 2020 11:12:20 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id mp16sm4739987pjb.13.2020.11.20.11.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:12:19 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Will Deacon <will@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: meson: ship only the necessary clock controllers
Date:   Fri, 20 Nov 2020 11:12:15 -0800
Message-Id: <160589952949.11499.17291456333845583802.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020075034.172825-1-jbrunet@baylibre.com>
References: <20201020075034.172825-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Oct 2020 09:50:34 +0200, Jerome Brunet wrote:
> There now the menu entries for the amlogic clock controllers.
> Do not select these when ARM64 is enabled so it possible to ship only the
> required.

Applied, thanks!

[1/1] arm64: meson: ship only the necessary clock controllers
      (no commit info)

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
