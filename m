Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F942A8A25
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgKEWvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732584AbgKEWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:51:00 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01269C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 14:50:59 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b12so1503663plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 14:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=NzA0a885DJ4XJc9zARU6pOWYzV9t77/ibehK8SPM9oQ=;
        b=La52Ivl6ubmEHVSnYNiFwsdizLW825HKvQkMsjzLTt1SQigWUqAOd3r9JOSdOIcXzo
         tyo2EVcRJuNRD3JFf9ZeLXVx4ozsKDaPm49dsRJ1t+X8eFf1PexeXX7MTbcuXQytLvF1
         AntPbKiQW8Y07FZTOd838uFP/MirLhUZmQBUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=NzA0a885DJ4XJc9zARU6pOWYzV9t77/ibehK8SPM9oQ=;
        b=RMU3JSZp6pHLQjQV0rFiZtwrM4/GLt534Eg90T7o3bI/6+M6JKz6bRvFy4f+xN0wT6
         xeIeHeZWgWqdBXqChdT3Lc5NsIAlpalD0VzCdZpaEgDFN5oTdppny0PlFdhvHXyybmAe
         KhheE8tQ9KhR1kKIM4/VBC5ekgDOCFtqYYAsm+8kifB4wBnbJ4uhfNmasU1ZojzT+Fp4
         M1JMEQ85P5wRdH4nlHhDAuYIBKRCSU9Aohts2rM28euwGX7TL6ZjpKeJR40Kl0i6cKIG
         s7Ii9irh1ltfSJbD24s21qcjlSYFnwvNa/NDwcMJnziqf1DGtZv6SC3hptTMCTMhyp3l
         FjLg==
X-Gm-Message-State: AOAM531oLTGU5gtg+3Z9U8pw19Rr5Lq7kTVme9cMtX5+74ngZVrY3kmt
        qRo4lLnnSMPzTXM9uGW/tZOmMg==
X-Google-Smtp-Source: ABdhPJxTyfO3NLtXjhQrIzyMZiY8zwVE1mc0yQBahQO5ZY1R9bcXnV5XTMxaWNbY/+eg/MbszYlhag==
X-Received: by 2002:a17:902:bc47:b029:d6:d98a:1a68 with SMTP id t7-20020a170902bc47b02900d6d98a1a68mr4049384plz.63.1604616658533;
        Thu, 05 Nov 2020 14:50:58 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id k25sm3742425pfi.42.2020.11.05.14.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 14:50:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200220052701.7754-1-leo.yan@linaro.org>
References: <20200220052701.7754-1-leo.yan@linaro.org>
Subject: Re: [PATCH v5 0/9] perf cs-etm: Support thread stack and callchain
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Leo Yan <leo.yan@linaro.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Nov 2020 14:50:56 -0800
Message-ID: <160461665604.60232.10802283348863949674@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leo Yan (2020-02-19 21:26:52)
> This patch series adds support for thread stack and callchain; this patch
> set depends on the instruction sample fix patch set [1].
>=20
> This patch set get more complex, so before divide into small groups, I'd
> like to use this patch set version to include all relevant patches, hope
> this can give whole context for related code change.

Was this split up into small groups and sent again? I didn't see
anything when searching lkml.
