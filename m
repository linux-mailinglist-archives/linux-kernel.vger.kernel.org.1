Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A89206A7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 05:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbgFXDUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 23:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgFXDUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 23:20:34 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9EBC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 20:20:34 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id e12so602645qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 20:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=4II7Fw45SEF920IkbnWwp2/fRzagFHT3tXeov4ux/NM=;
        b=SmH8gBGNh3nKwQmONhcNE7Ajv5xsl1YULwBcG7wVwuKnCpvAkYeKvlwH1F2rdSIi0g
         AinySVmUkTlvROIyLhRveOcxqlbyPt4G031GSFJ4cCWzprVPTqofs2BUwF6ZLiHTUg6K
         vduFMXllxWSVrgtZBOEAcscEbNL4voAFdOTF7wAbWpQcmilYHlw04gzY5vcUxFzHIs8R
         UmKeDtqYxHLegpLJn4SHrQL+5i265BevHXGMHJrhNsKdKQf7yiBkhmwaYQk8JDZGCiHn
         y2/7omnsJo840RVx8YM5orsfVbhF9Ddb6qrggjbdKQ9OjHE7W7SyTEg0+Gcb0JwlVb5g
         FPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4II7Fw45SEF920IkbnWwp2/fRzagFHT3tXeov4ux/NM=;
        b=uCXt/mSDZr6aoUHdiJ9VbiaJBuA/zHtbHiXUCzHT7v7IKGev7gZOr6QNEfcQXdWlEz
         kdUqms+H2U3EK0pVfxcHHiNw2GQswRRwj7J1jTS/ieceHjhmEfS5LPE7wTiBfJEWNtPF
         0r47s4Aqxx6tabm0vhb/+3tTPn7Ml2Ohk/yIlXINIrjRGGx6CDHOCwHx70K6hNY/4WEa
         eyJrtohNTFg1cfuGDakVNqPbrZjyo3vwYuwp8+ZV4NjVPpKPGlvMAJUr0qAokqKhEW/g
         a4kJS+C3Nh1Km0Ar5Nzmwh9KOKaYwowzcN7fhD3B8u6qCnT6wXyazbpf/+/L/BGQn3vf
         HbRA==
X-Gm-Message-State: AOAM530CBZuamckFxGOAusv8HGesxIeGSLy4+yZ0hxsWVz1OiJ/LIu1Q
        /VXker2BB6O9zZ6XTY2F4v96ZuPICyDk3O34IB6HxGes7h6ENg==
X-Google-Smtp-Source: ABdhPJzo+vCrB//oaczUYyWxogzRufoZWiM39mxSSQ6ECW6ptBmGeseOkOHniUli6ewV2RXc5bIXd7R2hq2y9zqCqbA=
X-Received: by 2002:ac8:7284:: with SMTP id v4mr17185156qto.267.1592968833406;
 Tue, 23 Jun 2020 20:20:33 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Wed, 24 Jun 2020 11:20:22 +0800
Message-ID: <CAAvDm6bO9tauB8jnEUcM8pyV5e_SnSi70vincLd0fbUwXmT6og@mail.gmail.com>
Subject: Are there still some methods that could be used by the Linux kernel
 to reduce memory fragmentation while both CONFIG-MIGRATION and
 CONFIG-COMPACTION are disabled?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Are there still some methods that could be used by the Linux kernel
to reduce memory fragmentation while both CONFIG-MIGRATION
and CONFIG-COMPACTION are disabled?

Are there some system settings that could make for this goal?

Thank you for your attention to this matter.
Best regards.
