Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4040B21D542
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 13:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbgGMLvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 07:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgGMLvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:51:40 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A000BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 04:51:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y10so16733455eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N/DHlb+/nZGG7qN0r183zUnGDtK3Lw0uwrnh4HpX2MQ=;
        b=K9z4OQXgZqe68WhodObjskXGXhCveTrRy/diBpkEHckhZqpZTCKRqwWhv8gL/c0eJQ
         HE/ddd4Que9btx6TMvG1ZAjd5MQ39PL1LEH6CtGVG0IrQy0m2Ri/anZu1dieNaHGnA5Q
         95BZwQjw2WGS50mSmx9I5AIEuFbYZ51P7KjRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N/DHlb+/nZGG7qN0r183zUnGDtK3Lw0uwrnh4HpX2MQ=;
        b=Lrh9OlrC7yvrasP9KS0r3IFQPZrYXq7OWelpummnEQ1yq0GbwYgcCjR1TfMvBRk5Jy
         5Br5jIiMTDGEOoB5oGLESoTxxcEp8FwjPo4Ja3RS9999O/zl6n7t+6+/ArpIRcPZi8JS
         SeWfoxiYPka5yhVIaqESL9zAwO7QJ9XhBcCDuDzchPo/FBVRzepsF2kxJfnzNqgF5tf8
         vnFJyYJ1MK2NTAT72+WknfI4ZS0dGa7Aq7bPm2yb1dOzfK6cHRcCTa0gckTWQtgeJ5Q6
         GVG+5kASll4L/sBGWxN7PVlELnrD5LggujD4lZsuYgyOF5kxbQTaMNkWqxeMeWh+wopY
         CpaA==
X-Gm-Message-State: AOAM532gQLikaXmZUnp4jySAM6HFdo8sjtN9ImNaFl+0wET42MAy+XBL
        0sMJX3DaA1TK+h4J3RKF0uRodw==
X-Google-Smtp-Source: ABdhPJyPC6ve+saeYmK+j2jidO9325RIY86E6K3eIRiMv5vbBmkdi1CVDxd1dgGuDRIoWh87T+IKCQ==
X-Received: by 2002:a17:907:94cf:: with SMTP id dn15mr78740469ejc.457.1594641098243;
        Mon, 13 Jul 2020 04:51:38 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id s1sm11306128edy.1.2020.07.13.04.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:51:37 -0700 (PDT)
Date:   Mon, 13 Jul 2020 12:51:37 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-wireless@vger.kernel.org
Cc:     Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: Don't IWL_WARN on FW reconfiguration
Message-ID: <20200713115137.GA1065134@chrisdown.name>
References: <20191017144841.GA16393@chrisdown.name>
 <20191017145321.GA1609@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191017145321.GA1609@chrisdown.name>
User-Agent: Mutt/1.14.5 (2020-06-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to check in again since this is still happening: is this expected?

I expect that if this is IWL_WARN, it should indicate some unexpected or 
non-ideal state, but the card seems to operate just fine afterwards.
