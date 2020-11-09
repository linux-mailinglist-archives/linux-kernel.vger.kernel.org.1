Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583FB2AC17C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgKIQ4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgKIQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:56:39 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C42C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 08:56:39 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id t13so8932503ilp.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 08:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hb/7csFm2Ot68mGoKZFYFHroBSfAtn3JReEYKuxRQao=;
        b=Pi7wF3ovUi7Kba8fgczc76Z3cExIg8fdajRKSEfu5/lsorBm6nLKBAYjlfbO9GASoU
         cy3e/beXlxXtA9oKxqR4iaE4ASHDQGoabb0Abknra/GR6UZcD5jZMXPPuSRjgqSoMH+H
         8rBEyqKfIXM+usW4uzpJnPiAYQ+gRWcUi1nIZuoEyGEsXd56q5mXYXvbmXUjSU90m0wQ
         vo1yrYubIyUswgbmp/15GIJsHZYl2Idds64yej4SuYr3Y+kPVtYAD04wqifwlnhYZeJK
         a8pjTTyy0SG0KvNTx3INR/vqgibVqHG9xmbcbLBfPq0fbAIFt8wMlOfNxvIHdo6g2mag
         yqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hb/7csFm2Ot68mGoKZFYFHroBSfAtn3JReEYKuxRQao=;
        b=YCGK8qZuDS2TlglNo0MkTebamzLYfVSfnDBz6AuihuxvSwmGb6iTobUv9rp5bZkYMQ
         5br1i8jFFMab8XwSizamhAGczHEq+2ghAyMpJLNMiCiOYpLPZpU22DAyNrvy4kPHfSdm
         gi6qjdpPgXB+9VHEkTquCjbek7i1z4KOpgHIS5bdOK1j1gmdmkuaE/Xq5M9sK7dSp6Zr
         ROQfXGLXw9/vRYmxtPN1b9vae+b3xsWRCDl+9UnnaIHG5Ap2N4bt4LepUTirvRBcEp27
         m+BhQsZangARl8Gs733baFwOM3B9+Mn1fjZPZRqGgqh9ZUp23bGzcXbqeduyD10235bU
         z07w==
X-Gm-Message-State: AOAM532pzXLmBdbR99gbYtx++0TeAWbO/4ufS8B2oeJg6nNu5LrvrI8o
        3VWRfoGjfYYwdxsVv6eywRAJWQ==
X-Google-Smtp-Source: ABdhPJx7JXuJC4U4Ni5xMxauvqtZk1OahLn8ybdO+EYg1THppI0bhOue2eG18do96vWMijA0TkG5vg==
X-Received: by 2002:a92:9903:: with SMTP id p3mr11613874ili.138.1604940998941;
        Mon, 09 Nov 2020 08:56:38 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j85sm7576556ilg.82.2020.11.09.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:56:38 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: ipa: little fixes
Date:   Mon,  9 Nov 2020 10:56:31 -0600
Message-Id: <20201109165635.5449-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a few small fixes to the IPA code.

The first patch appeared in a different form in June, and got some
pushback from David because he felt a problem that can be caught at
build time *should* be caught at build time.
  https://lore.kernel.org/netdev/20200610195332.2612233-1-elder@linaro.org/
I agree with that, but in this case the "problem" was never actually
a problem.  There's a little more explanation on the patch, but
basically now we remove the BUILD_BUG_ON() call entirely.

The second deletes a line of code that isn't needed.

The third converts a warning message to be a debug, as requested by
Stephen Boyd.

And the last one just gets rid of an error message that would be
output after a different message had already reported a problem.

					-Alex

Alex Elder (4):
  net: ipa: don't break build on large transaction size
  net: ipa: get rid of a useless line of code
  net: ipa: change a warning to debug
  net: ipa: drop an error message

 drivers/net/ipa/gsi.c      | 7 +------
 drivers/net/ipa/ipa_main.c | 6 +-----
 drivers/net/ipa/ipa_mem.c  | 8 ++++----
 3 files changed, 6 insertions(+), 15 deletions(-)

-- 
2.20.1

