Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04C8277312
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgIXNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgIXNtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:49:52 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DE0C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:49:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f18so1930980pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=nDFkx6bRZ+drPsqp/l6BBUZR+PYth/F7dL5uLJhuUMY=;
        b=jksutbx4PB3mYyVCRh5QWym5vyDS0yz0ZGlsyMToKmP/kSUIfgvjgcNBMAVAsA15Gz
         WfhAN0stc65Rk7IDKrOI2KU6yrLsjWKs7Be+zmy0nfQU9v0uzHd0py5Ia0WRzY6CX64D
         MirAQe9t5ZwQPIcFajS1QiIqz23nz3dc+oZ3uYn55l/voYx7uC0soi86p+fEcsfY3DN/
         9+16jXDlYvg7bbn5rLm/1pP9yaRi4vD7dH6d62up6QfaIW/o/N1oibdmzcV4SQXB+kEt
         WBUF74qQ9J8BTIgxnPYg9y1AC+dGFAXghGUmXY/oxkuM6EBhnLVog+I6R0lOLQQR7cQB
         51EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=nDFkx6bRZ+drPsqp/l6BBUZR+PYth/F7dL5uLJhuUMY=;
        b=lwmlB8mwSDNBnK73Zuu7u6tRbFFN3XhwFaAgkA4ZNLxCN6jm8m82acnT64MRH+T2jv
         xsSqeTtLKi10nFG6+inFT5tC0nzvhQu3BkhOqzLWBJiT3CeJlidKGSeVPNAak2EOUreS
         EMGSmq/gthgyjFr6Aq5JB26hj78Fkm+xQULklSBUEYnQ+5KBnFa1+p6VGWxlkfcnWGAp
         j0zkjy8RZLTtHPrumvP+l06x2tk7PT4kBypUtk23CAM3acYEi91cQ/TdnreeqoJ2I92l
         Ey5R1FD43gRvVPUt/s+sWzfZGz59IbngfvLBAMQBEtFhfQX2/YRNWAiHUHkUGuTZgdTR
         owww==
X-Gm-Message-State: AOAM530x90REV2t67l7Iau1AVTGu478hDLbxeBfeusZoFmTkIMf6uWyg
        QDmSQ5BqxhljbIjscBvPkrUEC/Lx2/vwTcrO
X-Google-Smtp-Source: ABdhPJwbd1LSl2/gftLCx03fHeD04pDcZ3PWYrKB+M+YFRWFAxdOkEFBi1zveQY/kTrqDkkb36twNw==
X-Received: by 2002:a63:1c26:: with SMTP id c38mr4207665pgc.105.1600955391262;
        Thu, 24 Sep 2020 06:49:51 -0700 (PDT)
Received: from debian ([122.174.146.186])
        by smtp.gmail.com with ESMTPSA id b11sm2926012pfd.33.2020.09.24.06.49.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:49:50 -0700 (PDT)
Message-ID: <83e908594c7bdca8585ddba35c91896abc9efa45.camel@rajagiritech.edu.in>
Subject: TEST
From:   Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
To:     lkml <linux-kernel@vger.kernel.org>
Date:   Thu, 24 Sep 2020 19:19:43 +0530
Content-Type: text/plain
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is  test mail

