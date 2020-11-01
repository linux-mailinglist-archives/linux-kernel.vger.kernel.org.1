Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9472A1F7A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgKAQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgKAQVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:21:10 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB4CC0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 08:21:10 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id r8so7633885qtp.13
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=9EpNaWNd06Q2bmObI93Ti3pWcScI+CZMVZ3CT0jmF0c=;
        b=mc5PEM2edUNp+JzsSssolxy4pg3WUEoyzaxbQa81VjH3N/NxIZucgXWEnMHyZDik+u
         OM33blOknu5TbjyjafIlfIYXjWjzorxtqA0IL7llAAzkQTM+BBJAgFL1fD+Wo5YZV3JC
         fLvenBNzJJfPdJcjkptEzaWcjQf10MEyOUiJ5xInVEfIWO5EnAwdGsIWNsCPAY+q2gTa
         hXB0ssZZhBpNGdT9LhAZGrY9FlM1gtKaNNH7VS2mH5aOOfKP3OfdkFJNuKYzfMPubrJs
         e6oohxEZnqcshUqet9pDz06diS1ili5bFse5xEJVt1j7jQxD0fYSoMBQnxSUs0c+WNca
         IMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=9EpNaWNd06Q2bmObI93Ti3pWcScI+CZMVZ3CT0jmF0c=;
        b=WdZF7FtRFIrulSWw/H831Zift7aHDibdN9yWoyW+odDMMlfv0HIGGzuyvI/syMoxpz
         VcGuPWSbFHEL1fKv1NYmSmWZ6JD4QMAOGm9PykV0zeNTSWfpmAgi+a94Yl8mc60Un8pQ
         UdiFG11vI3rf/tWbm97WffuR6FhtSeqEwbXJzl4BLvpVi0YhzXCZ1K4ZGZaA2zLX4KnJ
         xDtlCxthMRzQjHVUIjBLpesuaQDAYm5ev0nM6p145tq+Xlay075QPzT9XVO9g0ztFSJt
         oD6YRopQc7Ok08hm1cXJTaHoXYiq9TgSO3wVPQOebcywkJei7jPA+79qxSAy1Tkx01ln
         Tkcw==
X-Gm-Message-State: AOAM533EnAoNrII/GaU2VIHnCjyGfU6ICQrlZfZkPpoUUVvRZWKCp1mA
        dya8IRMRaqXfLnyY0AlnDM3zeL4UnGPSPA==
X-Google-Smtp-Source: ABdhPJwhQB7OKnbZdpmjZ37FQCu4Jq1lK40Mc9E1KKg0y8N0IB7OcfXoaqweejKt+Rv9CGSJ7Xawiw==
X-Received: by 2002:a05:622a:345:: with SMTP id r5mr5194897qtw.222.1604247669465;
        Sun, 01 Nov 2020 08:21:09 -0800 (PST)
Received: from [10.200.10.3] ([114.141.194.12])
        by smtp.gmail.com with ESMTPSA id z16sm1206270qka.18.2020.11.01.08.21.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 08:21:08 -0800 (PST)
From:   NASA Jeff <tallboy258@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: BFS revisited.
Message-Id: <C1349666-3472-486F-BE46-1B521B81BD3E@gmail.com>
Date:   Sun, 1 Nov 2020 16:21:03 +0000
To:     Linux Kml <linux-kernel@vger.kernel.org>
X-Mailer: iPhone Mail (16G201)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a somewhat imperfect, though short script I knocked together that fix=
es scheduling issues.

while true
do
for i in `iotop -P -b -q -o -d 0.1 -n 10 | awk -F ' ' '{if ( $1 ~ /[0-9]/ &&=
 $10 > 10) print  $1}'`=20
do
       	ionice -c 3 -p $i
       echo "process $i reniced to idel as it was hogging io"=09
done
for i in `top  -b -d 0.1 -n 10 | awk -F ' ' '{if ( $1 ~ /[0-9]/ && $4 =3D=3D=
 0 && $9 > 15) print  $1}'`=20
do
       	renice -n 10 -p $i
       echo "process $i reniced to idel as it was hogging cpu"=09
done
for i in `top  -b -d 0.1 -n 10 | awk -F ' ' '{if ( $1 ~ /[0-9]/ && $4 =3D=3D=
 10 && $9 < 10) print  $1}'`=20
do
       	renice -n 0 -p $i
       echo "process $i reniced to idel as it stopped hogging cpu"=09
done
sleep 0.5
done
