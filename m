Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144652FD29E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbhATOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390107AbhATNke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:40:34 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0997C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:39:53 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id h25so567377wmb.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=4HuaHnHsq3+9UDKnhuRegf7VhNzlZpKuJ1R6ivtSlOg=;
        b=RzwwBhI0LFDqKRi3rX8rfrpXZflyXVI8WUwGnh7kHJ3Rle/pz7qDeRwRyRnlJJPqD8
         AbDOl6ZRZHzI3FdOtQuR5PVuvAF4YuwgUucDI82DRg70lf7PQ85hM5g3qcrL/r9Ci9LP
         4E4wX5o5GFVFLBTVo18e+aywt/VYrsTcwYihokSuh1rpKBOiBOd6wYW8/eEJTHrIaTzG
         p/ObA5CGL2n/xo3pYACU0NdLVle/TTdGtxEeWFUsBoQjdYdz0hBfb67exaOcXtXOE504
         U5/MfbwJNVd2jtfthveCkpFwMRLuiDS0SN5W2OBNZTOseChuxpzulx0V/jtV8eeL+iM1
         809g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=4HuaHnHsq3+9UDKnhuRegf7VhNzlZpKuJ1R6ivtSlOg=;
        b=JFutIRjGZdb5zMLsEgoV5pAsPldnW0sblFn16v+Q/RnJ7iR+0ScjhKHNCoU+8i9web
         oeVcnRtH4RZ1PXob4hWFiLUlUr7OSEjzf4E7VM8na3KUZRzKQsdeTqZObq58E/inKOKt
         EFijOuU41hSaGT6GFBAGn1syUsBhKbzu7Q+LIQIXvVZ0aoi/XGFC1D16LDdR8+/R1dOo
         GQoVhIJBGB4DKnWkPYPF1Th2CRvcvIr/sOVCT3piWrkCNIDw1abUFkajNcBfS8dqVy6O
         ETDMqUccY+IPry35X11ABLQQcrSs9Cz5IVKiq6PiGu8PSk6Db9nJbtSWsAFBSxJ0LzRi
         CRQQ==
X-Gm-Message-State: AOAM5321CCjdNX+PzqRfD4VG8FcFZyAcwyCk3+UmaJgGqN5cxbTat1KC
        6bkn0SCdGhrSlZoI41qvHHzcwKS9TuWj7g==
X-Google-Smtp-Source: ABdhPJz9D0nnseUovWpFIZ6H+T0/V01e1hCruHihQvhd66s20FOaGPv8ik7N7xcP/s+yNf1ljx+YYerX46ujqA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:cb54:: with SMTP id
 v20mr4532747wmj.148.1611149992267; Wed, 20 Jan 2021 05:39:52 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:39:44 +0000
Message-Id: <20210120133946.2107897-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v3 0/2] BPF docs fixups
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Difference from v2->v3 [1]:

 * Just fixed a commite message, rebased, and added Lukas' review tag - thanks
   Lukas!

Difference from v1->v2 [1]:

 * Split into 2 patches

 * Avoided unnecessary ': ::' in .rst source

 * Tweaked wording of the -mcpu=v3 bit a little more

[1] Previous versions:
    v1: https://lore.kernel.org/bpf/CA+i-1C1LVKjfQLBYk6siiqhxfy0jCR7UBcAmJ4jCED0A9aWsxA@mail.gmail.com/T/#t
    v2: https://lore.kernel.org/bpf/20210118155735.532663-1-jackmanb@google.com/T/#t

Brendan Jackman (2):
  docs: bpf: Fixup atomics markup
  docs: bpf: Clarify -mcpu=v3 requirement for atomic ops

 Documentation/networking/filter.rst | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)


base-commit: 8edc0c67d09d6bf441eeb39ae9316fe07478093f
--
2.30.0.284.gd98b1dd5eaa7-goog

