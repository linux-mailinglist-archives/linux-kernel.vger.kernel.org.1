Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA7D2E98FB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbhADPkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbhADPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:40:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EF5C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:39:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a6so18835423wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 07:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:date:message-id:to;
        bh=xbM8olnauZ7kp/0Zi02Ib1Rv+Jxq5Xr2vPN0TkSoeeg=;
        b=jqlm41/0MQX6Mcyp72x7c6vdwH8IMoQRWOdVZOi3AexvXapfGpMBaUF6Q3UVHtLpl6
         EZ+9nLiiqMKs2DdjpzI4KATcdi12Z7+B7A8yYYYEuv7ro4nMqLs3mBuQrru1IOf74Kbo
         qDnIh7Uwi6ilJV5SjCYi1+cLX/tm5RM8s6dX5MU9edMBMtr/b1q3fwp93BTNFeaAIW6H
         ivyVq4ZtBWZ659+p5vv7ekwAxhXIKV9DeSgGL+Lh27lEoQLI1iuId9fQRUOFtvEuHFRZ
         x6Ooq/7F/OPCCLiPYZIvQhdwH8B54ly6nNlNB0Vsiocvt5Pgv25sDEod7c2kAChwt18A
         zkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :message-id:to;
        bh=xbM8olnauZ7kp/0Zi02Ib1Rv+Jxq5Xr2vPN0TkSoeeg=;
        b=shaLCXRIdXmaHdlJxvy7t5TuAjRjjh14+SY8xWKeihb1j3SN95sUTI3/sswyxfd37k
         jOkTV82NACacCskeu8td8rYFLlmbE947whMRCBVKfsdQTo6z0OGSN263qUIws7SEV6ni
         0aagh1mqvwoIbrywn3xHXPwpkhyf/1eDmRtIPWtnP0twP6N8YWO5bdjG4GyOLZfN98Di
         9uxrt3piDR7CljXuMOt7YgdCt+9vxgl3jaaxjXLRJLZF7oiJBfXKvRk05+NEh6kK0jOG
         jByE0x7lpszkRhVgj/G2KC5cAwkSfc8adFGRY2Qh5J1vuNYVN2NhwPW2YZpFO+KRn2a+
         lJDw==
X-Gm-Message-State: AOAM531PZyd8IJq5pk0IaOAwK5Utb+PCG2n0RB7y0aXY0yPLIiZZdTVr
        wqIJzGdFTMgfjjaooCDT+e7fgyXAu5TzhA==
X-Google-Smtp-Source: ABdhPJwJdOQu1o9p53UhUwNHVHaj5ZQSj3xitWbMX7atnUtKWs6V+9Pf0193syLSaowqW9AV+/mlDw==
X-Received: by 2002:a05:600c:cc:: with SMTP id u12mr27982296wmm.42.1609774790269;
        Mon, 04 Jan 2021 07:39:50 -0800 (PST)
Received: from [172.16.53.52] (bzq-109-64-198-198.red.bezeqint.net. [109.64.198.198])
        by smtp.gmail.com with ESMTPSA id m18sm92045287wrw.43.2021.01.04.07.39.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 07:39:49 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Avi Nehori <anehori@gmail.com>
Mime-Version: 1.0 (1.0)
Date:   Mon, 4 Jan 2021 17:39:48 +0200
Message-Id: <C74E35EF-1923-4707-A64C-167C4DC31DA4@gmail.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   auth d61d05b3 subscribe linux-kernel

Sent from my iPhone
