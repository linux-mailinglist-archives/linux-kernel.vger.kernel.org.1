Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B488214A96
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jul 2020 08:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgGEG0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 02:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgGEG0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:26:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5F0C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 23:26:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n26so25242152ejx.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 23:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=JVZu2kYmhMYJfA54P2B/yDBUxtqwl+eiyX2S0Azfd2M=;
        b=TLDv3VXqw5o3aHzqyM517wPQBzFv+s0nTNaZ2LI8auS2YLmjmpMSI4jNyjpqCf/z3G
         Y/980Rapkk9ZSb4KislbSEq9uQlmUMnrQ7O3wK5kGCkaF2nGzOJWdDWznUGwjU2vvEm1
         wIacfdg48cL14t5Ksfxmx2QkrG6Px3nK0q7RVark1GzfJ35y9LMgbRxuwy0MBqCtRJFj
         Y9PuxTLcjuAl+PQcgBDlp4bl7D1EM2iuzuKOhlXn77megnZHTo/Udg8jIktzBBPhJOx7
         gzLvnRi5//8Zx1MzTM4dOtGln9QVx4Dyg9gMBqskwsLyJCP87h/oiqeQbRr89VQDv4pT
         ar4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=JVZu2kYmhMYJfA54P2B/yDBUxtqwl+eiyX2S0Azfd2M=;
        b=E2jVBQr0b3QWsuxvZCrEvz9YMcg0K/wHuH6gevJTuXsfdYFK4F0GJ4tlVYEjZ9PTVA
         AhLORe2KVXeesSjOBPqggPQ+AciIZPBvZ4X6Qva1MMC1/cFiAY+C7sQ4qTEErym+YZln
         lFYjahwV6FG4GfeP9NLs+1ZG9EgzNXFA6tGK5Ed+M9kaXXaEfirvKxb8iTE32HvsZ9eu
         rn/DwvbicsvyPR3Awsl1+gKPzQx1dPMe435O/B15YOcJCsWBDvQKmiFX6k8X2rE/sslq
         SqWUrMqXnJQ6ZemdRW8c41oQzIx3f57E4m8ePUAuHkvdqF7GXgwVJRZWGVYOBxmIvys3
         IYgA==
X-Gm-Message-State: AOAM533SqrRDXg/J37RNxPBGeqaHEWENgEHRLN8s7G6lmAAFGUlcgIPC
        XGZPGfI0VpYJVJ23mR7tKgDN74qA
X-Google-Smtp-Source: ABdhPJxgXi/emF2RIcwaZQWzb2tM8osSFQsCM7C39hXAf08QbvefqMQV2FY6YDUCx+bmIhf43exZ6g==
X-Received: by 2002:a17:906:2a5b:: with SMTP id k27mr37537968eje.82.1593930400318;
        Sat, 04 Jul 2020 23:26:40 -0700 (PDT)
Received: from [192.168.8.9] ([197.185.103.3])
        by smtp.gmail.com with ESMTPSA id g8sm19795434edk.13.2020.07.04.23.26.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 04 Jul 2020 23:26:39 -0700 (PDT)
Message-ID: <5f01729f.1c69fb81.1c942.56aa@mx.google.com>
From:   Gldm Schs <sisulumax213@googlemail.com>
X-Google-Original-From: Gldm Schs
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello
To:     Recipients <Gldm@vger.kernel.org>
Date:   Sun, 05 Jul 2020 08:26:29 +0200
Reply-To: schsgld@yandex.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 =

Good day  I have a confidential business transaction I would like to discus=
s with you. Contact me on schsgld@yandex.com for details.=20
