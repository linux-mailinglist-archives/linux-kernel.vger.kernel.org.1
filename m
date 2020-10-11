Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D4E28A9F5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 21:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgJKTqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 15:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgJKTqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 15:46:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76665C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 12:46:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t9so16587640wrq.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=IAwrxUc0CangWu/AFOL4gGXMZRVsVBqi+fT6dr572ko=;
        b=ka44MuA7QrRu95G7f53WQno8YwJhAmk8ndpdqPC/52ILQS5+LVjd9Ha6AQi9CX6d+L
         5OHS9YtQ/J7a+9iDH5RzXwComFxfiJemZHTDYLsnmJdd7Uw8nAmRfRzxxuodzLeVoAfk
         st1a5wOTTUUvMbN3WplTLIWkjx7W+2pE1l+L4dst5PdLV1195c9Lwa1G2R9S8Px9L1hY
         p+Y03tQYOSblmxaTUI75Bv3KSD8Jt6e4XF9U/9dYNswJrkkL6FUnejdU8z5husOjUUZf
         JzasS/eC2nC10BqaYBdiqGTELnbONnqDuoJe1nRIAumXXzoDWmyEmf3wpRUM9eRpPTpc
         tsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=IAwrxUc0CangWu/AFOL4gGXMZRVsVBqi+fT6dr572ko=;
        b=R3gjXMq7Gh0/4Vq3zbNP2X9LqbfJnWinagA9M9p1EMAwsudxr5T1BrdjEG6aAoPWMc
         Rj1MNrSlpCGgL2vXxYbsdGLJwStMPwWWBMTudsEuTL2oBOV/yU69B0fTtiq8nc2AmLjs
         Ai1mwy/GKURyuTqcMj/drpwqecBIJuF/aOmLfiAOZ1Q3u/RfH2Tcg4uQatXAsoXA/niG
         5Lk5BUwBok3CKdeU2vjrIxwt9B+5NokFq07H2DmlmT2sjXQjnyA/oycXxPLolq+bObSy
         VsSlqn800pTesPX8AKAXuqwDzpdfW/4xqoweU9aQ2DFoCIWjSWG4kALDIBeTCcaPXU+j
         iL2A==
X-Gm-Message-State: AOAM531OXXzNiLrORTV8R0fXcapdyijI+E1Kg0jqinHMI19sOoq+lcuJ
        8f0sXWN3eXD9PS9oqaMWVvQoqEJUlhT8/uhSqE+uVpA4WyTJUA==
X-Google-Smtp-Source: ABdhPJyGDGETUYPa6VNMyxIQulitGOHKcPnya4uR8hu5icFrfqgfC9O/iEj74beomiQuoxjM+p5kbOM5IPYEqsLgBLs=
X-Received: by 2002:adf:f482:: with SMTP id l2mr13570097wro.26.1602445574678;
 Sun, 11 Oct 2020 12:46:14 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 12 Oct 2020 00:46:03 +0500
Message-ID: <CABXGCsOVXh89h2e4EuNbDKiCNwKm8599UE-h0GN-jPhpfyoCVA@mail.gmail.com>
Subject: [question] What happens when dd writes data to a missing device?
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!
I have a question.
What happens when dd writes data to a missing device?

For example:
# dd if=/home/mikhail/Downloads/Fedora-Workstation-Live-x86_64-Rawhide-20201010.n.0.iso
of=/dev/adb

Today I and wrongly entered /dev/adb instead of /dev/sdb,
and what my surprise was when the data began to be written to the
/dev/adb device without errors.

But my surprise was even greater when cat /dev/adb started to display
the written data.

I have a question:
Where the data was written and could it damage the stored data in
memory or on disk?


--
Best Regards,
Mike Gavrilov.
