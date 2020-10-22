Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B53296618
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371840AbgJVUlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371812AbgJVUlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:41:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB0BC0613CE;
        Thu, 22 Oct 2020 13:41:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o7so1709623pgv.6;
        Thu, 22 Oct 2020 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BWdJyFnxLJJv7g1dniL95LZkF1RGu1MUOYGhv0a1qrY=;
        b=Xth8Ri59OD4xNWnhRaQ8huBfX9e0INd+t10Hk4cOkjoe7ZPfAouha82Je6YxfJmk9A
         lnCPA1u0R/k0lzf1IM1J05pwg6CNVmJDG3Yu6tVJFQQpjH8V4xwKiw59eOy78GrXp28E
         YpSue4JONOiqboy4wvVARGJPmWMXjILdIGknhSCMuHvKwMHktZMvVr1yXz3aXAZQN3HB
         Rfdk2G8NSaoUB4jcDlAcM4sqiyvaeEZsIqh5P3uoS0hcEVOtAWJbUa0XE7KJveeHzBij
         QlUEPZzEAD4+LIq4hTwDtVtVB35TOPyWEnoh0a4FDvz1RWh880g2ZazmbgqAzrghxW/P
         39Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWdJyFnxLJJv7g1dniL95LZkF1RGu1MUOYGhv0a1qrY=;
        b=Go1s1CMt2tCZkXAfXwAoiu9XH/Od6+liz5HOOpCSEDTt22VPFy2lBjrPFEet+l93tV
         ki1sylrQMjYprJ9QzIFjsGoAQ7k+AAECp683OBmeoQLhoHpUDIzYu5kkzes9cC9t5Qoe
         shqJbaisD6o3ZaE/8AT7SrQPyFG0THWO6bg6eBxx/MJlkMO3Xn6wuHZBrN3DMeXAl4OB
         S3WY0nkGIVLKZigclVugD22T0G1/PW8JgJ933sKe4OgOBkA8n8MTurCsmsdfxiV5TeA5
         nD6l9y1L7jrgfzDZdbJX5wOL0spYaTfZI4IX4wTgkWeBGVDp6H5tH9HylYFXmrXKnQ02
         oBPQ==
X-Gm-Message-State: AOAM533HMAzuosX/wGPP3vP6IVShEh1gRgB1wGQynK0uS5pgbfM5gp39
        hPYv1S258N5qbzDzZrSIuOE=
X-Google-Smtp-Source: ABdhPJzOS3xr49mUCU/M/8BNegOeBgXDfW8pPhVUUsCYT5jo/4wLlIdv1sqhdN+N9qtbz4u2AuAgIg==
X-Received: by 2002:a17:90a:e698:: with SMTP id s24mr3952526pjy.72.1603399274094;
        Thu, 22 Oct 2020 13:41:14 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i25sm3309578pgi.9.2020.10.22.13.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 13:41:13 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Vivek Unune <npcomplete13@gmail.com>
Cc:     devicetree@vger.kernel.org, florian.fainelli@broadcom.com,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: BCM5301X: Linksys EA9500 add port 5 and port 7
Date:   Thu, 22 Oct 2020 13:41:12 -0700
Message-Id: <20201022204112.232338-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c51b1d53c9411a4321ddcb1dbcdb0a42945b23c4.1602701516.git.npcomplete13@gmail.com>
References: <cover.1602701516.git.npcomplete13@gmail.com> <c51b1d53c9411a4321ddcb1dbcdb0a42945b23c4.1602701516.git.npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 15:27:27 -0400, Vivek Unune <npcomplete13@gmail.com> wrote:
> Add ports 5 and 7 which are connected to gmac cores 1 & 2.
> These will be disabled for now.
> 
> Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
