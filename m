Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868C5215111
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 04:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgGFB7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jul 2020 21:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgGFB7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:59:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5DFC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 18:59:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 22so37630067wmg.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 18:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=DNwuyy+w2miGGLoADvKOC3+/92ScbyaMWz+JLs5k/EE=;
        b=BL4D4l8GUQbmdkhJ3wX/EBey7TblgEw65n24qPYGrJyuMowR7FBYMztOOUO3dBnwNU
         uTnaG61s8ucd38yedH+lwu61FeZPw3HyJKpcsJeX+mfTXCQUiORgg3LEgXBdPH1GbE7z
         dU7oc9pzZya4QtFwSHsjzEHqBFPR8NFjl57rd9T8pNRbK8iHW/xrNtgDwxqi4XCNE3Gu
         HpBiifAdNKIzE6a5ANz4K4lfce/LdXMmSgT9e9BU4ubt2ZL1WXtMtHHHLv+dksIQDUmN
         joHVsBp18g87QlDKHQlANmPtVJs7jXgvmVZDYvdvTD6uNrSrNV/kOdp7EM3GpcD590IB
         HOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=DNwuyy+w2miGGLoADvKOC3+/92ScbyaMWz+JLs5k/EE=;
        b=iQZXea1QEy/mVRA81fAw3gpeGQrXZcHhX6k8JWGcMeH6hxrBfRbD+buUrhVHtS1Qlo
         1eUiJ/4jrwBf6vPlwnimvMtQKrriMEQtIRnG4vbrjTNWv28OL9Ek9AtXP8A7XeO1Ln9w
         jUP0TPzyMNFV/5IERwugJmpNQ+ubROE87AK/et9AGftO4AQw3uyzG5Uqcox17RfXxGh2
         +jBmpq2MnNihK8lStLEl7/pG2b9eMD3wJllUDZ1FE9uFgLM1geSH7RkjZrLVCzM1qMwH
         KUT9+YtcEx5Jy4v0Nd70Jf1UVdIPfK5xCKb+Kuc1g4nk8HU0cGJWohdlbGXJV6njkBmf
         7WiA==
X-Gm-Message-State: AOAM531mZhSWsESRA91we58oEkPqHirDnty+U1xWneImG+o+y8F08bkj
        V/nVrLJA0bNA4W6MFlt5WPJnN5lB
X-Google-Smtp-Source: ABdhPJzQ4q+GyvgJPZaBrxnJHTOmzC5atrTEF/07eWDSy+a50sY8+wUnMk8ZU69GM3kR79/OBuPl+Q==
X-Received: by 2002:a1c:99c2:: with SMTP id b185mr49967816wme.52.1594000787108;
        Sun, 05 Jul 2020 18:59:47 -0700 (PDT)
Received: from [192.168.1.64] (bl8-158-27.dsl.telepac.pt. [85.241.158.27])
        by smtp.gmail.com with ESMTPSA id a4sm23395787wrg.80.2020.07.05.18.59.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 18:59:46 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Andre Coelho <andrealbergaria@gmail.com>
Subject: new binary algorithm
Message-ID: <52ebf588-d092-ea5e-9c17-6576832d01ae@gmail.com>
Date:   Mon, 6 Jul 2020 02:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hey,


for those who read my email, i upgraded tjhe algorithm

here it is

#include <stdio.h>


  // The algorithm works by first getting a base of 0000, and change one 
bit at a time (0001,0010,etc);
// Then it uess a base of 1111 and change one bit at a time 
(1110,1101,etc...)


int main() {
     char zeros[] = { '0','0','0','0','0','0','\0'};
                  char ones[] = { '1','1','1','1','1','1','\0'};

                  printf("\n%s",zeros);

                  int iterator;

                  for (iterator=0 ; iterator < (sizeof(zeros)-1) ; 
iterator++) {
                     zeros[iterator] = '1';
                     printf("\n%s",zeros);
                     zeros[iterator] = '0';
                 }
                  printf("\n%s",ones);

                  for (iterator=0 ; iterator < (sizeof(ones)-1); 
iterator++) {
                         ones[iterator] = '0';
                         printf("\n%s",ones);
                         ones[iterator] = '1';
                     }
}

