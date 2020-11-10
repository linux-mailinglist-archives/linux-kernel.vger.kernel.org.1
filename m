Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413AE2ADA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbgKJPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730432AbgKJPkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:40:05 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823A1C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:40:05 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id v11so8448953qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=C7DgpMN+QdZwRC94GlKCs7UdjVL94KeK6yAm3EMjUqw=;
        b=kBHJNsnQkchbzVxKBYhcI9dzelq/Y6q73ucPdPfaqP38HwzA/7KDkMfGesoFJV3q0c
         YrN/uO/AmX1UZZx8MnDFpIenN5nNXYAg+kGjWuyw8YsSr00QruluffzQ93OA7LRngN0i
         xMgcLzREQwwFF9mZ/8tkgikvwMf7AaxfiuPptlq70B6Sf7p6EMM85j6Qvg+HrQvT/SV1
         +PoINBI7NkLN9LCmsDOQt4yfQjcfuDTXv3QSDf1ongJA/iNcCzwJ1vypEQd4ywjmGi8s
         83J85FDIek0igGpIJtgQsnHyC+awLtOD+GAFWlApiUVHwX+s1y5RLEoxJ8dh9vHQYpXY
         +hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=C7DgpMN+QdZwRC94GlKCs7UdjVL94KeK6yAm3EMjUqw=;
        b=YOZ9Gf05VdXTAAYl3FalC3Hjy1vvs0y51XZs+ut8QrJ3XBnlhWRyUAasnH349YXQwI
         5PwewsoJX8HUklhJfzTTSjNzA/JN59/viP6jDCpzREKcGkjqZa9NNqtr8sCkj8010VvT
         BARCA66ElthTLPTwGPM5Iq6DlH9Oqz8E61uBiYTYz6IiC+WlXDE2fcsz4D6dV05Fw6H+
         7DjLbg+ygQxY2ZXFi0w25w0UMpZQegu2Oa1sK9eKIHG0Ne0VShM3HNbuYT12CkvV1V7h
         +I+JcMnM+j0jNf4fBQX/AHfFhAzPoPeFyg34stJO3E1O6MX187zv0lgQkZkPX6fmgmJk
         lNFw==
X-Gm-Message-State: AOAM532whpSpBtSZJK8ry0v5ZuWKm1GLbj18tZzv3F0+9blj8CbPziZ3
        p2muwWE+ZFOHISLkk9tOQgUD1DJgyRmP7R06DP0=
X-Google-Smtp-Source: ABdhPJxczS1TqGOgJLPdqgVcQn8bfSYODBgxIcKqmSIkDgN34Ip9JamZJnHun8yKFNXGLHLqa9vablefl1x99MT7C/Q=
X-Received: by 2002:ac8:7083:: with SMTP id y3mr18872388qto.248.1605022804710;
 Tue, 10 Nov 2020 07:40:04 -0800 (PST)
MIME-Version: 1.0
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Tue, 10 Nov 2020 23:39:53 +0800
Message-ID: <CADjb_WSwW4jrNvLp91YHu-qimU1P1itPU_gZ5juQRWER_vGWAA@mail.gmail.com>
Subject: bootconfig length parse error in kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,
Thanks for writing bootconfig and it is useful for boot up trace event
debugging.
However it was found that on 5.10-rc2 the bootconfig does not work and it shows
"'bootconfig' found on command line, but no bootconfig found"
And the reason for this is the kernel found the magic number to be incorrect.
I've added some hack in kernel to dump the first 12 bytes, it shows:
"OTCONFIG". So printed more content ahead we can find
"#BOOTCONFIG" ahead. So it looks that there is some alignment during
initrd load, and get_boot_config_from_initrd() might also deal with it. That is
to say:
data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
might do some alignment?



-- 
Thanks,
Chenyu
