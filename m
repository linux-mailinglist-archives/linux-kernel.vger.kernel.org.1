Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB322887BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 13:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388041AbgJILRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732307AbgJILRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:17:16 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5EBC0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 04:17:15 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f19so6575878pfj.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sdKjLE39B7ygzVMKXpWDsFa+IvvEq27MGJewZf/7lCg=;
        b=Nw+5vsPOCAS7UG8LvQZQR5XoQM3EArj6MEMgN42MSx2WhLXo2n7CqMWoffdqNQO7VM
         H7dgPtUyrr7Bp3AiXcgiEbnIe/jL0Y0Q6/um7ChE5MT3umLjSPAjnzJKQVp560Q/Yjom
         dlCs3XWucYsx6mDUTX9krJvWc6elh11ttJykknP3DgnW2LKqjDCcUXmJbKPmTzQDtKi0
         zNxQndFXYPyZlmveBrH8+Uu5WhAOjdpbpDfE7MKxaiiRNRaC9boPkeXTZloCWU8+xArI
         MspHoYYS4wcIqWGuCoe597m6XBZM6hhGrNhklKo/h/7rOD1n+KUg+SXlzW9wVYkXyoIQ
         bI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sdKjLE39B7ygzVMKXpWDsFa+IvvEq27MGJewZf/7lCg=;
        b=WjLEcJB6pg5FOPbF8tvCpTeteFlVrQsz7sb6+ouzDIW4C6DIK9s7gOy+OxHdtwGYGZ
         Kja7EYHxkLtmZxmB0OeBjZ1C13Le7cULl2iqrylcQHHHwVTYzrykdba0vuV9OEB6610v
         a0aeBbonBoRxiv2uYCdONMQUNeea0t+2Fcf3GLChddF/olYsl4sIF5EEEidYbjenK/bP
         2mBeEMzZXNsEud1/doB0jrd4mQkYfonTNnWPD0cF0Y400ETjOA2qSlygBjhgNnpN4PFB
         +EBLFXyI8VgHQTzPb1VLCg3RJnhZdCXrHT/w0NIQ3+gUJrWL4/LP9MZ/696Ffu2oBh9A
         sG0Q==
X-Gm-Message-State: AOAM53137+ZZxF/fHEDNnqlQUWD66fegqSt/UG3kDZuxMtbSETyFddly
        iUZXLS30QzOlYER+DJVswDnMZw==
X-Google-Smtp-Source: ABdhPJxBKuG1iPxOpqq941k33Ge0O8I4ewjPMmBzrqpHWVf5NcOde3wtKA9HWOPkM8yq2Oo8IOl2rQ==
X-Received: by 2002:a17:90a:dc06:: with SMTP id i6mr4132826pjv.162.1602242234766;
        Fri, 09 Oct 2020 04:17:14 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id p22sm10941904pju.48.2020.10.09.04.17.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Oct 2020 04:17:13 -0700 (PDT)
Date:   Fri, 9 Oct 2020 16:47:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        sudeep.holla@arm.com, chris.redpath@arm.com,
        morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201009111711.5sl7m24engcwiqii@vireshk-i7>
References: <20200924095347.32148-1-nicola.mazzucato@arm.com>
 <20200924095347.32148-3-nicola.mazzucato@arm.com>
 <20201006071909.3cgz7i5v35dgnuzn@vireshk-i7>
 <2417d7b5-bc58-fa30-192c-e5991ec22ce0@arm.com>
 <20201008110241.dcyxdtqqj7slwmnc@vireshk-i7>
 <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <42e3c8e9-cadc-d013-1e1f-fa06af4a45ff@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e3c8e9-cadc-d013-1e1f-fa06af4a45ff@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-10-20, 12:10, Nicola Mazzucato wrote:
> I thought about it and looked for other platforms' DT to see if can reuse
> existing opp information. Unfortunately I don't think it is optimal. The reason
> being that, because cpus have the same opp table it does not necessarily mean
> that they share a clock wire. It just tells us that they have the same
> capabilities (literally just tells us they have the same V/f op points).

No.

> Unless I am missing something?

Yes.

Here are the different scenarios which can happen.
- Two CPUs have separate OPP tables, even if they are exact copy of
  each other, these CPUs don't share a clock line, but just v/f points
  as you said.

- Two CPUs use the same OPP table, i.e. both point to it, but
  "opp-shared" property is missing. This is same as above case. They
  just share the v/f points and this is the preferred way instead of
  duplicate OPP tables.

- Case two with "opp-shared" property present in the OPP table. The
  CPUs share clock-lines.

And this is exactly how we find out today if CPUs share a policy or
not.

-- 
viresh
