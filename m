Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4D72B4B77
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgKPQlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:41:45 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33808 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgKPQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:41:44 -0500
Received: by mail-qt1-f196.google.com with SMTP id 7so13325171qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4ZH/LjNb3Hokat0rYv7xscgHOsbb+sHkrIrtYELG2Q=;
        b=R4RlypE43NEuGg4xg9mtVUr7FbOZXj6x9X+33SBQ6R6E8sHExasyLMEV2BcOLYVLmj
         KxoN6Hl/YdGRzA5h9tGvKFFs/xGY+Xjz3JVTaCzzBcPTELfzXM++KfjO+p8RvKK3vf2S
         eQkxSo6W+SD/JQhIpnQUWNG+xuiKyxEM56IOyxxVQkb8PDYxT6jThu/7BfXnnV3cmrHH
         3ACqXfyauY3ConF/U48eA4G/0/f5LUgU1MaES8hl+hYj1nFAaDy7aG8O6Stt5JzGQtGZ
         w2Tl0xvf+Ekg9cDcMqJXKciPS2WnmBUnUmBxJ87w5i4KJWKP+yPMWl7hFd2QD2lhlXQ4
         OfxQ==
X-Gm-Message-State: AOAM530CK/mvrwC2fyZAFJJAc6fhBjmcb2m27PQXlQsXN6cBzce6GF4N
        99vYfauKBfdrLLuw+qFWyqxcgAMpUpuiDvq4xVY=
X-Google-Smtp-Source: ABdhPJwLLWHV3nuJNG4xf6VCpvfMCnZVWwbQzzB+GIpM5OFDeV6z4rlwp49XDc5/U433hjGY3578FT5go4IcrWrTjM8=
X-Received: by 2002:ac8:5806:: with SMTP id g6mr14914954qtg.292.1605544903546;
 Mon, 16 Nov 2020 08:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20201114023643.211313-1-namhyung@kernel.org> <20201115130824.GM894261@tassilo.jf.intel.com>
In-Reply-To: <20201115130824.GM894261@tassilo.jf.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 17 Nov 2020 01:41:32 +0900
Message-ID: <CAM9d7cgRQpSi5LE5NmGOkDtkZgZ4fVt6Ues=FpikpJ8CYEdJxQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Take cgroups into account for shadow stats
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 10:08 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> Actually thinking about it more you should probably pass around ctx/cgroup
> in a single abstract argument. Otherwise have to change all the metrics
> functions for the next filter too.

Ok, will do.

Thanks,
Namhyung
