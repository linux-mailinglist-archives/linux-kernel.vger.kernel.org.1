Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F01A91AD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 05:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393055AbgDODzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 23:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733225AbgDODzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:55:14 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B019C061A0C;
        Tue, 14 Apr 2020 20:55:14 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id x2so12221126qtr.0;
        Tue, 14 Apr 2020 20:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4k8kfX6jIEgDhdAPsrHcln1Ddwi4D7YyK+0yUrDlqSg=;
        b=RAfqyGIOObyvOPi3F4NT32FtHzHYlWzY/aqw7ooP/b65kZSkZU8Db+XlmbpQ1+wixo
         znKhltePa+CqaSMni4OgcdV1iESyIoA4OoRmZf8ZJdKkQmcNcbb1/kXukLBKxRU4snuz
         ZiAKh+Poyyf6Q1LsaC4a78ZaOC0+Tb7+q6OFqOVTBPo9yqZMz+6HBcbJI1QpE4ukR1wd
         UwUlI3AxMx6cNTnDP9WNT96npeqF+MpGxaAqF4Trvg42Y4KtmP0vn2lICuQNF9ZdRmVB
         R6bim1DomCYqoibTgJEhU736pMc1PqEtUwNpJons1XfsjzolG0VQwkuHj5KHem532+KG
         wiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4k8kfX6jIEgDhdAPsrHcln1Ddwi4D7YyK+0yUrDlqSg=;
        b=LWKnuocMnnVxHrlIZ/WTSIZCAIc/szjfQwN6T1eCCPQfDQGDRt1CMHHeji6TI/KE0P
         zWo50yueIYQDZPyQLcGLR/aw/b+Kg2jxvg3kqAiNGySlb2W6ZZiso9SrS3mPTu/9gkDY
         lu1cWuZY6jrBbUV4JtKgCRZhOwgXFcqdUoP4gWmioiH/v5vC1raeydCpo4cBS5Gtv2CA
         QlawObwF3SJCbqJv6x96BW/s2RBsrLOvHKGRActgHi1KzJzk7DGIgT602NUcC4xc2aIi
         fscTmjFEe2KkZbspu71dx34Pip3NbaJ2Yr4nIoAQV2bqMmbhD1TtnZp6DOpH9cbmKuCE
         GSaQ==
X-Gm-Message-State: AGi0PubW/W9qyqLrqYojQzIpWOlohjAZBBUPrD6YaciggSChRI54ZDhX
        YsprcyLutDdCaROuFbWODhpyf+k6sszYRA+L1EHS5jPV
X-Google-Smtp-Source: APiQypKVUr53Ap6X1FAFbvhxyuOhMjonhg5K2CaIS54M/pn4KBL5/M5iMESMu3/e4Tlp1RZatobKR+o+1gzvEI3MX/8=
X-Received: by 2002:ac8:4e45:: with SMTP id e5mr19662711qtw.101.1586922913095;
 Tue, 14 Apr 2020 20:55:13 -0700 (PDT)
MIME-Version: 1.0
From:   rishi gupta <gupt21@gmail.com>
Date:   Wed, 15 Apr 2020 09:25:02 +0530
Message-ID: <CALUj-gsRgkEyRe3vubEeWx8ENwEyE+Fzv4bKKDZ+iq3urRG0BA@mail.gmail.com>
Subject: Correct place to put the new doc for "How to use this driver"
To:     linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Team,

I need to add a documentation file to let users know "how to use this driver".
Specifically this one (tty-ttyvs.rst): https://lkml.org/lkml/2020/2/15/153

(1) I am unable to find any directory where it will fit. This driver
belongs to Virtual TTY device category.
Any suggestions where to put it?

(2) After putting it is it mandatory to link it to
Documentation/index.rst as suggested here
https://www.kernel.org/doc/html/latest/doc-guide/index.html

Regards,
Rishi
