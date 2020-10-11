Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA1628A6F8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 12:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgJKK1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 06:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgJKK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 06:27:03 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8795CC0613CE;
        Sun, 11 Oct 2020 03:27:03 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id x16so11254028pgj.3;
        Sun, 11 Oct 2020 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=sZ4u0IYX+prhPTXd0MVIePeS5ONiOotzisA3LcVKmGs=;
        b=NVS7Zyk+rjxHS3Fim/isNHWuIprg+c2HM+wV+yaIh9E7EihNDRfTuLYfDV41xq9uwi
         uOy69v3QR0MakTzpXeOHvayM4QZM8Yo53iwXh6iUN0gxncfE5J6OfSrEU+NP09tRfsWy
         azWSanp94VlkodpfsZAnL9oSYSL4iL8BYLySvy9LD/FO9r1yLEeOgr3fC8nztbDP92LQ
         G9S08ezRghlNaq9pE2mf0ctDyLhd7f2fihyM5OedkNQJ752yk40uE/lSP9QBk7aUs0gX
         K6vACT9vq9wS/+UZL+nxX8nEPzVWqh1jqZZbpMgWLfScV0dWp03Lp2DZ7IN6lHis/pB/
         YY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sZ4u0IYX+prhPTXd0MVIePeS5ONiOotzisA3LcVKmGs=;
        b=WV3qU6torSkNfRD4JLqvYaAzec/KidRzk7X4KAaPOxuf+J+l4sOh8IVfCqgbkAqx02
         RBgOZJVTBxrHVUPIhEhIEoNfZs6qddDOU+fxModQPsSthuQ2zPhtL0dd//BoooNFFfJp
         8n0HF/02Yd22bVERP32B7GlK8ajFs9Ez8Kuo0YS6pdVMxz50KsbY0u4Omc+n+LKtOmv3
         K1ZG5UuDE4LBwEHKz0OEOTRAOc8dhJ/RzswLyE7MOkqaQBysn0TXVuV0hyL3yOZdiump
         8OURpDPmPktUxWD0cO8ejLPPiqeXWOM5LYZk5D/ehTCampGgm/s4W2Ak8dARKPsOgF6N
         86sA==
X-Gm-Message-State: AOAM533RS0r4jWmfDSG4nAp53DsNIPdr9DO19tcjmy2Qpqt8S8QBc5t6
        4wkI2OqrqThWpT9E33OqMSQ=
X-Google-Smtp-Source: ABdhPJxSlKHZz4nogWT9Nt3kZILi1+8lgygZc0KhYqgDj9p1Hb85VG4EdeKLcxVdM5B7uicpX/BFwA==
X-Received: by 2002:a17:90a:6301:: with SMTP id e1mr14656301pjj.131.1602412022680;
        Sun, 11 Oct 2020 03:27:02 -0700 (PDT)
Received: from adolin ([49.207.215.73])
        by smtp.gmail.com with ESMTPSA id y4sm741762pgs.0.2020.10.11.03.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 03:27:02 -0700 (PDT)
Date:   Sun, 11 Oct 2020 15:56:57 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     corbet@lwn.net, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 0/3] Improve Coccinelle Parallelisation
Message-ID: <cover.1602410019.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently, Coccinelle uses at most one thread per core to improve
performance in machines with more than 2 hyperthreads. Modify
coccicheck to use all available threads in machines upto 4 hyperthreads.
Further, modify the coccicheck script to improve portability.

Modify documentation to reflect the same. 

Sumera Priyadarsini (3):
  scripts: coccicheck: Add quotes to improve portability
  scripts: coccicheck: Change default condition for parallelism
  Documentation: Coccinelle: Modify Parallelisation information in docs

 Documentation/dev-tools/coccinelle.rst | 6 ++++--
 scripts/coccicheck                     | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.25.1

