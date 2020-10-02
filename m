Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD2281E42
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgJBWYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJBWYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:24:47 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12528C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 15:24:47 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id y194so1342431vsc.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 15:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Is9HMQBaKKpXSbhbkh1D21fxGJNsnpUrasuh/KfwOMs=;
        b=LrkwPd555VbQlCZQ4xerSYMa0Gu7RuBh/yiOpWcQkbL6/qFkXomFafvaB+/MIVXo56
         UBGC2w9Y3SA86our4/801mlePd7aZjptVYZ+lOa/4nPJgC584tBwqYnAiKaDqGMjAjZ1
         Xy4f19llRVO3lAHvjLjmxxgQxtl1Chl4/sZRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Is9HMQBaKKpXSbhbkh1D21fxGJNsnpUrasuh/KfwOMs=;
        b=tgqN0+sjwEBMDbziVjnyng4BNgi7jHdlIP3gg4UzjS37vSjYTkuJMWEXNxD8F/4Mc6
         PYhGHRh1N4FKzjP593qRXdDO0VkOR8/p4Bt00OsLf55Cwh4TzlijuwenqyC2S8B/60QV
         u1xFRzDYhnj27oWg8GY1xPQ6uwm8RRumVc1d7TYKooz2nbiKCYUZOeIO0pOsg2fIWTD/
         NfmZuHRYexEGkd5S/PlpteYO1mSao/WpemQlHY56Ooy9lWUI67s4Hu66bOd6UdTECXdx
         m/FASUidEFKvnt/FXFJFrTiizJv0HBJyhkkAyapgyERjme2dqUPxa390HrV+8paNhMlv
         e5cQ==
X-Gm-Message-State: AOAM532RC+b/9L+SSk5rEZnNkGSmxDEEC6L/LY449AcXtJFtckQ+vQuB
        HcuX3ha6T98yx6FSIPo/FZS3Z4yDs9yQzQ==
X-Google-Smtp-Source: ABdhPJzfQ+I7CcJ2t1gPRbNenXmOUJ5qSWWs5LfTZgmThvu1yHmx5fXYTSNnunwIdCAouj/SNd1CNQ==
X-Received: by 2002:a05:6102:2f7:: with SMTP id j23mr2626939vsj.35.1601677485922;
        Fri, 02 Oct 2020 15:24:45 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id b188sm455668vke.40.2020.10.02.15.24.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 15:24:45 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id 91so257673uas.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 15:24:45 -0700 (PDT)
X-Received: by 2002:ab0:4542:: with SMTP id r60mr2618461uar.90.1601677484614;
 Fri, 02 Oct 2020 15:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200929205807.2360405-1-evgreen@chromium.org> <20200929135741.2.Ia3b68ac843df93c692627a3a92b947b3a5785863@changeid>
In-Reply-To: <20200929135741.2.Ia3b68ac843df93c692627a3a92b947b3a5785863@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Oct 2020 15:24:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XDYS_QdwM-O_m0Pw6efkbTX+6UZSjqhjuJ8xDwMpZy6A@mail.gmail.com>
Message-ID: <CAD=FV=XDYS_QdwM-O_m0Pw6efkbTX+6UZSjqhjuJ8xDwMpZy6A@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sc7180: Add soc-specific qfprom
 compat string
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 29, 2020 at 1:58 PM Evan Green <evgreen@chromium.org> wrote:
>
> Add the soc-specific compatible string so that it can be matched
> more specifically now that the driver cares which SoC it's on.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
