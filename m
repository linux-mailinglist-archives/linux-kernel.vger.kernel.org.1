Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5972D25DF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgLHI1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgLHI1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:27:44 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9DC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:27:04 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 131so13207520pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLvXqcuRAnwClpMeWqo0QZa4oVJ4xTd0hMNtnI1KgKw=;
        b=LnOo3u7pKqtXdNliB6dRqdNlwTv/ezGz57B78Rynd+xyI+nwouKYfb9nL9tjiy+DFH
         9G3l1SwfW2VU5p5QbyvCwCBNNUgtNV4+qjNGOo9Gfcux1yCOZv/FkfMf1mm42doOAGK8
         RI8ihDDap1YziJnjM01AvdT0M3AovwVFzxMAoAu9Sg2TzC3Cd4EuyseYwzHqlE9AvYJI
         EXaCVvVrHftxVTirhIj7+ccUw7bXYjlscWMPH74h55FBGK8qMp5GDJNjfaZujMMGoVHe
         y0o4hU+uiMeP4bsvT/uyh70VPVWTtC662WZxWbL/SGMONHr0U3TT0jVbUUDQjk/DA1ho
         R/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SLvXqcuRAnwClpMeWqo0QZa4oVJ4xTd0hMNtnI1KgKw=;
        b=XEuwNqtZBe911sfh4k/uv7lphKnx6Era0iM26LQqKc6Gdl7eId/3CA6jwN3eFo5seN
         BDqvqunNF3lRSzXSFX47DzS2yPbhVy9lzdrApBFZrzSJxVTAYOZFk29YW3h5ZEGZksDC
         hn28kMC9ZeGUGvFPDHg3xnMAP+Oc7kIXQsjC87hK/cuXWPASv6feOeYNcMA6uO6abIIA
         j/S9tv5xNzRecwQv/mdqxs8bZYiMtPc3esFN6u87hYhf7QYWxKYrGj+Hr8ov2v8bfvmr
         tNmbTkh6glcowNuMx3WMRbwSDaB9QL1idQphaiLO5zhvC/2cdXGVmxSwLGxsXcjVGmwd
         1j4A==
X-Gm-Message-State: AOAM530a46pO9/IXRXtimqxbvotOeXlOcqWjyduMwj2WyrZrXsjI3EOT
        IvT8yYpNGBW2psrIciqGq30=
X-Google-Smtp-Source: ABdhPJziOWdNexMuJzJ7EUmZckZaby7roBHPZQUNSQDO2SGtNfj78YApW+l8y98ph/wfVtGutfR7uQ==
X-Received: by 2002:a17:90b:350a:: with SMTP id ls10mr3265775pjb.192.1607416023936;
        Tue, 08 Dec 2020 00:27:03 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
        by smtp.gmail.com with ESMTPSA id q35sm2469483pjh.38.2020.12.08.00.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:27:03 -0800 (PST)
From:   Robin Hsu <robinh3123@gmail.com>
To:     linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
        chao@kernel.org
Cc:     linux-kernel@vger.kernel.org, Robin Hsu <robinhsu@google.com>
Subject: Please ignore "sload compression support" patches without "v3"
Date:   Tue,  8 Dec 2020 16:26:05 +0800
Message-Id: <20201208082605.654422-1-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Hsu <robinhsu@google.com>

Hi, All,

Due to my mistakes, patches for sload compression support were sent
without "v3" (version 3).  That was corrected by resending them again,
with the correct subject (with "v3").  Please ignore those emails without
"v3".

I apologize for the inconvenience.

Best regards,
Robin Hsu

