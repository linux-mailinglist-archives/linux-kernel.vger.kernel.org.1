Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50D02EF70F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbhAHSKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbhAHSKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:10:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1BBC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:09:50 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y17so9844112wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IbKiK/oN0P8hq8HD/CB7DWifHFW8YC+ivJjR0jmvkc=;
        b=VAoj70RMoc94jq9LrcCZxLi50Lxghn26vl+q+0rOAk97j5kOpdskPxkV7YmBCZfW08
         D/L3q0xOSeuUebbIoconytkgbYohn2Si43yUaqeoWx9VdC7hy7rK37RnIbv9iDfo7RKk
         XlK1QLxoQYzoUhmbjdfHPMiSMIBLwy96fqCG5M2evTPxcEp/OVLqFfjNMLa4quwGbQwV
         CPkA2sSyCVd4Tkarh2fBMIzi2GiUieQVirT2aX+SOGqeisZN0dxsvLRbTDtHVpoGKHw7
         k1CKp1O8iBUoOrEQehTcMjrrTCZItE1j2DOMaUlbhih/9hijK2GLhoqLhUQoFQoIcvWF
         +e0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IbKiK/oN0P8hq8HD/CB7DWifHFW8YC+ivJjR0jmvkc=;
        b=hgo5QsR8IEmNsY9WZEYB4McQrjIKqxKXc+XWiR+1cjTMhEoukenqwHOfFmxcm5a0cV
         /RWrk28Ke1alMHLHivA2c/NOWryn8+yC8ESGb1hKVdjVuoQT1AfNM1KhDZLDCyKEL9RT
         PIPxSMhKeXzoR310SgzDBATy6ZB6qF2Ufnpx3KRtLUKPmNxYmlWqw4P2v1B2glFNYjhc
         tMYf1ijKM6DWhME6cb9O+nK4nuq4u/ei4xXot6/IuZILgHUzcB5DBqK4llPDrGOfgs2M
         Xs3yaxu7L0OB1x1/dFnR1I3VXQYNOkAOMaMXyxCCpt3W5WC7nYG8Hk1f3CXHnC0sUyyB
         mk3A==
X-Gm-Message-State: AOAM5312UV7rmKfMMv8d9H1XNpFO7JkhNOFJCt7QbNmqD+5uICxgYr6G
        J1e4QMvk1h4gp3QnNjGxHnGzzQwJ2UDPAThWZ8grBQ==
X-Google-Smtp-Source: ABdhPJzk6Ad8zcisTWrHoOev20gPJmK38ezUKLlGJxiNHmMG20qleMjHa+gnOk9WlwkWBefTgUUxIKmR1nh7g6I8VzM=
X-Received: by 2002:a5d:4587:: with SMTP id p7mr4671668wrq.178.1610129389412;
 Fri, 08 Jan 2021 10:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20210108142752.27872-1-james.clark@arm.com>
In-Reply-To: <20210108142752.27872-1-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 8 Jan 2021 18:09:38 +0000
Message-ID: <CAJ9a7Vhx+V9Ldm4R3ODYwyP27PFXhZQynpW2am_S1vTG2_VhEg@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Update OpenCSD to v1.0.0
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

I have tested this with OpenCSD v1.0.0 + Linux 5.11-rc2.

Reviewed-by: Mike Leach <mike.leach@linaro.org>
Tested-by: Mike Leach <mike.leach@linaro.org>

On Fri, 8 Jan 2021 at 14:28, James Clark <james.clark@arm.com> wrote:
>
> Replace the OCSD_INSTR switch statement with an if to
> fix compilation error about unhandled values and avoid
> this issue again in the future.
>
> Add new OCSD_GEN_TRC_ELEM_SYNC_MARKER and
> OCSD_GEN_TRC_ELEM_MEMTRANS enum values to fix unhandled
> value compilation error. Currently they are ignored.
>
> Increase the minimum version number to v1.0.0 now
> that new enum values are used that are only present
> in this version.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/build/feature/test-libopencsd.c           |  4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 15 ++++-----------
>  2 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
> index 1547bc2c0950..52c790b0317b 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -4,9 +4,9 @@
>  /*
>   * Check OpenCSD library version is sufficient to provide required features
>   */
> -#define OCSD_MIN_VER ((0 << 16) | (14 << 8) | (0))
> +#define OCSD_MIN_VER ((1 << 16) | (0 << 8) | (0))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >= 0.14.0 is required"
> +#error "OpenCSD >= 1.0.0 is required"
>  #endif
>
>  int main(void)
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index cd007cc9c283..3f4bc4050477 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -419,19 +419,10 @@ cs_etm_decoder__buffer_range(struct cs_etm_queue *etmq,
>         packet->last_instr_subtype = elem->last_i_subtype;
>         packet->last_instr_cond = elem->last_instr_cond;
>
> -       switch (elem->last_i_type) {
> -       case OCSD_INSTR_BR:
> -       case OCSD_INSTR_BR_INDIRECT:
> +       if (elem->last_i_type == OCSD_INSTR_BR || elem->last_i_type == OCSD_INSTR_BR_INDIRECT)
>                 packet->last_instr_taken_branch = elem->last_instr_exec;
> -               break;
> -       case OCSD_INSTR_ISB:
> -       case OCSD_INSTR_DSB_DMB:
> -       case OCSD_INSTR_WFI_WFE:
> -       case OCSD_INSTR_OTHER:
> -       default:
> +       else
>                 packet->last_instr_taken_branch = false;
> -               break;
> -       }
>
>         packet->last_instr_size = elem->last_instr_sz;
>
> @@ -572,6 +563,8 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>         case OCSD_GEN_TRC_ELEM_EVENT:
>         case OCSD_GEN_TRC_ELEM_SWTRACE:
>         case OCSD_GEN_TRC_ELEM_CUSTOM:
> +       case OCSD_GEN_TRC_ELEM_SYNC_MARKER:
> +       case OCSD_GEN_TRC_ELEM_MEMTRANS:
>         default:
>                 break;
>         }
> --
> 2.28.0
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
