Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE4D2A1FA4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgKAQr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgKAQr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:47:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46D2C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 08:47:57 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a15so2922176edy.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 08:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RG1Xyf+enxJeOG1N4GYHEz9od2UEl1LBKJ49qDh9ENU=;
        b=ci7k/I1wZxgix2U3KQbUNcPgu/8t7OBjM0QtaC7+cuyjs5Z7ordVoQbrP6OFFgwbg5
         LAC5fJfu6gWddP9S9lHnegaYyAxkt1xfAijb3+9tlLPDZx/vcB04k4lYAIFWED0WWFrK
         Pocnn/vSL+0hjZIyjrC090+/SvL9RXaeroDEUwESiITHSQohlxVMNHouGPwbBSUhFnr4
         R4wD746w/qBwVTiK+5toN7BWgIolFpd+YhsRVkLceBNwU4P2ikmTzHtg45CvA8bJqnG9
         Bn8Rh3AS7EBsPGNeuZ7HWrP8YP6PnGhBwF3KcdNerLWL0oe3FC7M0Fd0S2RH1ApK4gHn
         QsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RG1Xyf+enxJeOG1N4GYHEz9od2UEl1LBKJ49qDh9ENU=;
        b=BBxwlY7NkaOftFx3QHf1oBg33HV8cHqqhk1LyYkxEYf40j0Qx6hI6CCU2OcGYtKijz
         e5MhlpmFuWL7wfRocGT4scchStSGD3T26WO22FQuGPi2IfrexJWdpFCM4O/1+7/4kbnK
         Y81v9KnK+0vPhiHBDuwmAchs2y4J9IOiDKfXWuEYRK5aeBgxocUjrhSyCf3aQWnC9cVS
         M9ShfusxgpQVWpyds7NxwSrn/oGflpQqWP728m/9OgaiFJsVjntbf99SiCPV5fkDqF6z
         jiqqouUhohIrUYKEjn+RVYuUsBnhwcK1WiaT5W5Ovqgb84kBnadswDJ61sgQ13Ch4npU
         vRdw==
X-Gm-Message-State: AOAM532NwfCuU5gzYN+qMI5kAZutWRP9UV8Oz1orIwdzrjCIBcGdMfWv
        BB1lnOW1TJGDPxTU1bnfnK4TRyjp2xYtWdjbA4sCRCBxqqZumkyF
X-Google-Smtp-Source: ABdhPJwOCgG2xtJhyuqCFHqHfvll1+8DoU2fiLzOuMdzs1WGFYTH3xozMFLXC8QB+fO9o1aEyxOE3i80j+91h7l7wOU=
X-Received: by 2002:a50:fc95:: with SMTP id f21mr6309684edq.383.1604249276280;
 Sun, 01 Nov 2020 08:47:56 -0800 (PST)
MIME-Version: 1.0
From:   NASA Jeff <tallboy258@gmail.com>
Date:   Sun, 1 Nov 2020 16:47:42 +0000
Message-ID: <CAN-MDmoKGtxHiZiXSgiLGYjY7ny0qu4D8=GR-dSGmdC0G85r-w@mail.gmail.com>
Subject: BFS revisited, brain fuck scheduling
To:     Linux Kml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a somewhat imperfect, though short script I knocked together
that fixes scheduling issues.

while true
do
for i in `iotop -P -b -q -o -d 0.1 -n 10 | awk -F ' ' '{if ( $1 ~
/[0-9]/ && $10 > 10) print  $1}'`
do
        ionice -c 3 -p $i
       echo "process $i reniced to idel as it was hogging io"
done
for i in `top  -b -d 0.1 -n 10 | awk -F ' ' '{if ( $1 ~ /[0-9]/ && $4
== 0 && $9 > 15) print  $1}'`
do
        renice -n 10 -p $i
       echo "process $i reniced to idel as it was hogging cpu"
done
for i in `top  -b -d 0.1 -n 10 | awk -F ' ' '{if ( $1 ~ /[0-9]/ && $4
== 10 && $9 < 10) print  $1}'`
do
        renice -n 0 -p $i
       echo "process $i reniced to idel as it stopped hogging cpu"
done
sleep 0.5
done
