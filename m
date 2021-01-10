Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE07A2F04AE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 02:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhAJBTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 20:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbhAJBTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 20:19:23 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683CDC06179F;
        Sat,  9 Jan 2021 17:18:43 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id m23so14063552ioy.2;
        Sat, 09 Jan 2021 17:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=G5qvDQBeDE8iHwbJBYtyZN29CaV4vTYDLF7Pb5s9TRY=;
        b=Ur0VObv3Q6XS8NAOdYVYqABXmlwwgCe8C0lPe6JnyWCfMUnEEI4As3rfGNuu/sffsR
         BZfix6TcSz15iFnPAgazZZp2C2psKDbujakh95CKqg7MzrDKrbRnyT/TTPCW2rfXC7Zm
         /UFZ5dY5MrgA2+DPN7d7cic64BbCXztXH2HOx+Z+9W80NF9xhvwWFbZg9A4rXegN5cYs
         VSFTX6rKFUPlODvd+aSUJlFRtJMlG96eFJ4Ev3pB9aJzMS9j2vfe/jkGZwCcJViYachi
         uoOyEhxfd4YvMAHC1Ez0KQcTi4IpFR3g/Rxke6gL+fbdhY0WwwqdlIjlh+IKd1ucU6yI
         SO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=G5qvDQBeDE8iHwbJBYtyZN29CaV4vTYDLF7Pb5s9TRY=;
        b=Gvpae3dRDtjPUeBobRyjZEYcJHLJPXgPiAhbo+aOipopSJFSowugRNuOslXBV/ecsQ
         CIu7NZoQg2Dh0MGYME6KCUjhFKJXR8zdNksm0e4RVP6J+kP+uv6FMsex+3w4H8zaLhDY
         yZA/oQSe9a5n+y/Ef1Z1pZ5pOggl/tfx1nbrdBFUaGBfVH4ZZ+jGFF1SJNk7LaZHnOpM
         atJO7BGwcFLvcp5cTXYOZNREywGUeCL9Bfes9R3QPQ2E8aHphoLy33g0YpmKQTIeYIsm
         pQ2luIux+izIU1DdZKWcimghsHZPhmDmyIom4K1sPlbB/0GRlNhMvA+y5v4WaIfE9e/O
         fRNg==
X-Gm-Message-State: AOAM533WL4R/YJOFTOBtzjfkqHyWsyBu/iRtLJbqLHxkFkuy4VCqkdf3
        wJkvuspEvgRcg1qSthYkOFZcd/KnZ80eFf5B2zWvgC+U07szVQ==
X-Google-Smtp-Source: ABdhPJyYfquEcYxfT1FTz3V1pYJ5nQBH1EuYOW+cytsfT7u+Fv/oI1cdL9KyP7UonEKfIY2RFT0iiOx+RU8VqaesPkU=
X-Received: by 2002:a02:9f19:: with SMTP id z25mr9318359jal.30.1610241522644;
 Sat, 09 Jan 2021 17:18:42 -0800 (PST)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 10 Jan 2021 02:18:31 +0100
Message-ID: <CA+icZUUq9Skdt0ws7uqa3N9P5vwhQX6DrhfNxMvkoKMEbyWE-Q@mail.gmail.com>
Subject: depmod fixes for linux-stable releases
To:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was CCed on the "depmod: handle the case of /sbin/depmod without
/sbin in PATH" changes to linux-stable releases.

Do you mind also pushing...?

commit 436e980e2ed526832de822cbf13c317a458b78e1
kbuild: don't hardcode depmod path

That was the origin for the depmod follow-up.

Thanks.

Regards,
- Sedat -

[1] https://git.kernel.org/linus/436e980e2ed526832de822cbf13c317a458b78e1
