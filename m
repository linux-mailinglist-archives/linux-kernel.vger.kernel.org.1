Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF52297C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 13:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbgGVL5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 07:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVL5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:57:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12831C0619DF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:57:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e7so1585572qti.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dyUMcCezojLTzXM6n0+gm/KoG8tE7nvxkZhV/GXuulY=;
        b=BsbTrxb31zgs3cyFbCCTHSPL3751zNXx3Z22+GfrjihsAvHm+LXfLZe1/v1WYboVB5
         78QYmxYI91u6J3TiETqUSYp+AOIsRNKeYgYjcUwqKxeGI5xX1IxV8O34Q17B8LL1PE8s
         pS+EejtI4LIfM0bEA4oVCzRGNVb59jPBU7VciO8JQ/C+2krdY8VpAp9PUk7Stl+mZ/aa
         VLMYt1I3enq5T5gYriuvbpQnTr/Nil6j6zrWYUEm8UpupD/M3/yswdI3hj2sLpr9G/bq
         D7Ir4Gwr9zRumbkwLgPWzr4eAvpuOXP9HBJvkuFVbiG43ybGMcB3etUgwR+cDq1KlyiE
         PYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=dyUMcCezojLTzXM6n0+gm/KoG8tE7nvxkZhV/GXuulY=;
        b=jcPrbZtYAz15MqAZNXVmmtXkktuTqydHFrINdqpAX5LAsL4J7S9lvstvBB1P7zc8cB
         nxwNO66wdn/OVhoVRjxdTyaNUSvJF6YU2EhyDRKXYVIcV1awy4YbojL69zW9e5txkznt
         Nfks0Jym8bVFXG1QzBRp0kv9lZeWzRmF9y1RJ69HLPoAnROLxRHTgc90YphYmp35KjKW
         ZjtFUJey8F81+wRUq79JHr6qMdZUWGch7qqGyNzHXo4YITYLwQdhLX3+59fG3VGkTqYz
         QBURYd42E6cA/V6fWD8kR4h0l27zeb20OU3vFTwRSm4bogpvGfFVLZUPBzPM0hwbRl8b
         s1aA==
X-Gm-Message-State: AOAM531t/YHbq9Hm14ybWZtO80KdH38SrW1C9or2N+xnZhcaYQAMnwS5
        JOyFGGyrF8MXg2ERFIvRFuvdcZWuvWW8fd+TtX8=
X-Google-Smtp-Source: ABdhPJwgGdGJcvuidrvLKFNp2alnrxUfXC6gjlGwkP2qvAFMNEt/Z5rXGBGGL2O7RFCwgBrA2+vyPRrCA2gY1Jweef8=
X-Received: by 2002:ac8:7454:: with SMTP id h20mr32619433qtr.84.1595419053200;
 Wed, 22 Jul 2020 04:57:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:556e:0:0:0:0:0 with HTTP; Wed, 22 Jul 2020 04:57:32
 -0700 (PDT)
Reply-To: peterjoe2121@hotmail.com
From:   Peter Joe <pettjoe2016@gmail.com>
Date:   Wed, 22 Jul 2020 13:57:32 +0200
Message-ID: <CAEzia8tttXD-mnOxN-oF_dM7ExUk1_L8TfbF5g9rHfMoPhJoYg@mail.gmail.com>
Subject: Peter Joe
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQpEZWFyLA0KDQpEaWQgeW91IHJlY2VpdmUgdGhlIG1lc3NhZ2UgaSBzZW50IHRvIHlvdT8N
Cg0KUmVnYXJkcywNClBldGVyIEpvZQ0KLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uDQoN
CuyGjOykke2VnCwNCg0K64K06rCAIOuztOuCuCDrqZTsi5zsp4Drpbwg67Cb7JWY7Iq164uI6rmM
Pw0KDQrrrLjslYgg7J247IKsLA0K7ZS87YSwIOyhsA0K
