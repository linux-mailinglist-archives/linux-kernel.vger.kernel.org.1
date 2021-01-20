Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA962FD978
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388705AbhATTWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391821AbhATSqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:46:02 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFE6C061757;
        Wed, 20 Jan 2021 10:45:23 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id q4so12994190plr.7;
        Wed, 20 Jan 2021 10:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ia6awbsKTp8Y/OHTrNkojNrbZCc+h9n0c5uhLVndNlM=;
        b=eSi3o7Hts7hlc+psPE7j5Kec/PGslxCLCSrtgddOK7PeOLtUELUScC19XvhmHJ5u+0
         rXlqVKVY2zMJ1HWAueNB9GonOPcFaf/mtyEMczkFpV3wGPGIda8mkeZU3WKcHfGHRt4j
         aD/ACcYD1Hv8SktX/bHpw9/Ow484JyIxeAnfKDbqRypjWdJe7py1KTT8Pr2yfS3Q12/S
         kXHSIefq3Ism6JVf2Ip5kFK0simc85ZKhNN3HsO0ka0QcV2WHfz/55I4LajlfDHGCsEY
         Iml9mG0t2z2zC3r6sBXs+dFoCcddttdw3yOdLW5XOAhWVdV+LGXtXQ2hUuuEqzoiEjFR
         zk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ia6awbsKTp8Y/OHTrNkojNrbZCc+h9n0c5uhLVndNlM=;
        b=aDp1s5Jd74rNWFuUBMiid5BKqLSwqAC83jee/pKNFGXSpLT30Mvkkb5EGuejWVWv8J
         qWdOFzfub44u8wEYi8KV3kRdnnTKdB1qk8SPm+3XzzvlevghemtozsJO8MfUL2NluvNs
         fa6QS6V6AWlfZVnBXTS1g0t4V1b8xuPij6RSbHVfnuEcuNcoxxZZGQRsocqM8rAgEFB3
         V7gYputVpGMhOEk6rzl9ypvekxENX8NmrqtFsnwaoXCiwYXXWn0ZV4ALZnU5yc9Ke3sh
         yhZHfC6AlOdceKjq6hzwlEIbxy/Syh30fU8hffZPTIdvKfTRzOQftTQeAhNqWzuQGUze
         LciQ==
X-Gm-Message-State: AOAM533g6OsAe0RsxwQJX7QsYWrEU8DAHCiMBbXjDO9LbDYWEHar5X4k
        tSaWdHMyWeqd9YTo5iZEcVI=
X-Google-Smtp-Source: ABdhPJyhB9PHGnnWdxziLm9KpjmPL5UoX71QgHgl2PhJNwCoIZhwO1TLD702kIRSrpEGKico853KQw==
X-Received: by 2002:a17:902:8687:b029:dc:2a2c:e99b with SMTP id g7-20020a1709028687b02900dc2a2ce99bmr11204747plo.37.1611168322755;
        Wed, 20 Jan 2021 10:45:22 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y21sm3061846pfp.208.2021.01.20.10.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 10:45:22 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Bharat Gooty <bharat.gooty@broadcom.com>
Subject: Re: [PATCH v1 1/1] arm64: dts: stingray: fix usb dma address translation
Date:   Wed, 20 Jan 2021 10:45:20 -0800
Message-Id: <20210120184520.2093143-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119053444.23108-1-rayagonda.kokatanur@broadcom.com>
References: <20210119053444.23108-1-rayagonda.kokatanur@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 11:04:44 +0530, Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com> wrote:
> From: Bharat Gooty <bharat.gooty@broadcom.com>
> 
> Add a non-empty dma-ranges so that dma address translation
> happens.
> 
> Fixes: 2013a4b684b6 ("arm64: dts: broadcom: clear the warnings caused by empty dma-ranges")
> 
> Signed-off-by: Bharat Gooty <bharat.gooty@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---

Applied to devicetree-arm64/fixes, thanks!
--
Florian
