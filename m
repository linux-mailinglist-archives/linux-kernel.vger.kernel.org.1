Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053FD2F8FCD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 00:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbhAPXI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 18:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbhAPXIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 18:08:24 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E16C061573
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 15:07:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q18so12935095wrn.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 15:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lPJ0s6iX9KFfwSBfCSw4Y7AnU+kztMB4FqeRyZRy4wU=;
        b=mtBYeGR4xMzQYf0wvTCqFsG+l0Br4gXWAkc5+y+lvTofrBrhHmxyMa0hwJNUBv5PMp
         gtrFm98IDAaKaDtL39D6NH228NSgTiuoo4E2jWrfRbKfDnEdPhHptnMHtLg9qBiz2EM7
         X1Mhe+eGfmYTfL9Niw72sHYZNnO7G4oWtIjoLhLKJyq2XNmIlTDFBpVOzgZrAQMhhDqD
         Bxi/bWG3N97TkYPXya/qFWl5d/BDJ61fO3pq83wnKl3h2E3rQty6ykz2vqVvY8Bwy4J3
         eD/JY4Qo6kWartgVmVsbfaHMoKibGvWW4L5v09wq0qDL9mvC9dM3eU+CjdvUrTqbz0z3
         zK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lPJ0s6iX9KFfwSBfCSw4Y7AnU+kztMB4FqeRyZRy4wU=;
        b=O+wd1rm54psezOUdKw/hGNBDgrnhZxHgHQw5tGxFzWns51j/Xq7b2hiQ+iIyi0gc4E
         /80YaVycmT6AHenmEmxhw6KiI7LYwcSTZEtILjRB9p6w7QNcUYLeGgnjvfnjT5CjspXi
         v7d7G5aKeF7m+ZJE1Jve/Ua4xB89Up05Zv3FeacREYkFJbrM/x3B85jQ1PDzqPtnijuf
         qFkMCU8fQMSM0mwEGvHY5vXdbIBmbzQ9Qj4EGUTEXyAV49F8F+Dxvy0UixBvXI4nkn5e
         K+Ld6NJxHX9C8nkHLxrXDt3Uw9gKOSJsvauCtJA99U0Gk8IV8DkXskBpGw9uWj9q8V+X
         povA==
X-Gm-Message-State: AOAM533mN0Ttn0GhvRLQFWVh4CZW00CSsD9RDYvjSV1tyH/PVnJlgcCJ
        OIWjAGiqrgZqSxfpC1Gtiji1A93WQIU=
X-Google-Smtp-Source: ABdhPJyfauDX9e9WqFnxiA/1wrfN0XJob9L+Gmo/NtuwO1PZEtPQnHlcoqtnnKBWH6c1OwZwwH40zQ==
X-Received: by 2002:a5d:47c3:: with SMTP id o3mr14212334wrc.175.1610838462346;
        Sat, 16 Jan 2021 15:07:42 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:5d83:6110:837c:5dcc? (p200300ea8f0655005d836110837c5dcc.dip0.t-ipconnect.de. [2003:ea:8f06:5500:5d83:6110:837c:5dcc])
        by smtp.googlemail.com with ESMTPSA id f68sm6687086wmf.6.2021.01.16.15.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 15:07:41 -0800 (PST)
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Missing param value! Expected 'rw=...value...'
Message-ID: <27b2e02f-0840-2686-7aad-16274519dcdc@gmail.com>
Date:   Sun, 17 Jan 2021 00:07:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 60b7cab23e5e ("proc_sysctl: fix oops caused by incorrect command parameters.")
I'm getting the following warning: Missing param value! Expected 'rw=...value...'
AFAIK param rw doesn't require a value. That's what my command line looks like:
Command line: initrd=\intel-ucode.img initrd=\initramfs-linux.img root=/dev/sda2 rw
