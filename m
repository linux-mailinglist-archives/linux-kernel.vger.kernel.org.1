Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA32D2A7516
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbgKEBvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKEBvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:51:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08184C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:51:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id a71so259226edf.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 17:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=granulate.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GNi2ovThdql22SJrmXZSlfNmj0HVzEHMIO5CFwAWuos=;
        b=Zh9pvZEWxeb8YpYtLLygNZhW/dsb6YqKQG4K2AWRe0eizBs7j0DTcymH+HIbUWooa8
         2GiUL0yxKNbSvokAxggFk9cjOo5l4KWIN6+6o9PZ7kCuS1+zKrSGlWTIZb1tprZ4PTup
         YG5hFYC98i2IuJiLhLSCU38OTm5/F1M4O6Xwxt+WpEZhlBJbO02ACcGu7NIA0GyOt/pq
         6TyNCDUZTT4D5Ffbnh/if7tSCS3v/3Dq64yPna2roa7cSWLJQsIMwBmlzudPEW26e4zP
         u9cm8w7A3N2cIVyW7/OiAY8iPNTtGQ17F3O+r5yqWn7LyKVRB0zXmuLmVnOtZesygi4V
         oWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GNi2ovThdql22SJrmXZSlfNmj0HVzEHMIO5CFwAWuos=;
        b=obnAlTphPNxTFYlN6waeDB36axam+AnNJ2DtmNh9sd0lJZdXaqEOMjoua/rY+hPQXd
         hK7Ah5jV1OfIYUDi6guqJgyIOBtjMsXPKaRa7/U3xs6s8CTsN6cKBymzWltt+50mvBO0
         8lKkUrXj3ThE6bVP3VQRKFwfI2Hu5KyO/RmNrKnlLfYHo37o3R/g0EQ6p82MhNOpb98Z
         mmV7cDzaRc0/8kOCgq521JfWfbfmQClft92A+C1ZnSPxe8k3iqRsOqAb8MpdqSRCiZWO
         Dz0eY5KLIAcmws+S2LxV3sBn2Frz260Rdo1RpmORdnqD4uUCtseQircfD9y3tuW6acYj
         +MSg==
X-Gm-Message-State: AOAM53203k4Op8Xmc8Pd3GIIDpjjXw0j08q1A6DeYWk1dBNW9oBMhfCC
        sltKe8FwgzR7L1CNGJlzd0FpGg==
X-Google-Smtp-Source: ABdhPJyvIxWnvoFQk8A/jsS3o/pfUFtVriqSnbgpgeT0xnuQRPJknW0fBCx4hABKVsu/GaQxV3xPww==
X-Received: by 2002:aa7:d843:: with SMTP id f3mr253642eds.354.1604541089722;
        Wed, 04 Nov 2020 17:51:29 -0800 (PST)
Received: from localhost.localdomain ([5.22.135.99])
        by smtp.gmail.com with ESMTPSA id u7sm74521ejz.43.2020.11.04.17.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 17:51:29 -0800 (PST)
From:   Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
To:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>
Subject: [PATCH v3 0/2] perf inject jit: Add namespaces support
Date:   Thu,  5 Nov 2020 03:48:31 +0200
Message-Id: <20201105014833.1724363-1-yonatan.goldschmidt@granulate.io>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version removes some redundant "else"s.

Changlog:
v2 -> v3
* Remove 2 redundant "else"s.

v1 -> v2
* Add 'in_pidns' and use PID & TID from jitdump entries for
  non-containerized processes.

Thanks,

Yonatan Goldschmidt (2):
  perf tools: Add 'in_pidns' to nsinfo struct
  perf inject jit: Add namespaces support

 tools/perf/builtin-inject.c  |  4 +-
 tools/perf/util/jit.h        |  2 +-
 tools/perf/util/jitdump.c    | 84 ++++++++++++++++++++++++++++--------
 tools/perf/util/namespaces.c | 23 +++++++++-
 tools/perf/util/namespaces.h |  3 ++
 5 files changed, 92 insertions(+), 24 deletions(-)

-- 
2.25.0
