Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57682EAC1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbhAENnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbhAENnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:43:23 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B53EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 05:42:43 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id j12so29235169ota.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 05:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=v8NfrJK/tS8m2kNLcoCN7Or0wTdHUEN4ErmAkpamh3A=;
        b=S2a/Yo1bVTTqrNmdI4ArtmZd8AnNwnsHEUx5XHOgxWLBE6AZ3R9sTA+h74iL6jgLqi
         1WoNFobLvOpyQq82H3oTpZue563zh5eyHsaNe4nb6eESYfogWik0SI1uKur15rUfU2sV
         UEm6HeTOQpiu2tsTUNPAdKkHyCKMveNB9FQrXzW5D8UnnrczSYR+OAcRLzBQEhtEoX97
         x+2crfW97vMa0RtFbF61ZYBcgbClMAYLKyUXVgpOhlDZxtdi08jA8qO76Q5m03qs7W7p
         ++VfTfsJL5FrmE+nctoMKxpwJfL5v7FcmHp4UsZe5tqTzZVvtG1n0q7D5pdE9Bi7irPh
         2Z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v8NfrJK/tS8m2kNLcoCN7Or0wTdHUEN4ErmAkpamh3A=;
        b=muCoRzrLHfyjBFzzGz51K82/lQP+r2XxrHTrtaSoBimWQUaWjTTfEyLLECFroVEuMo
         lCT5z1d7Mcisr5PHrMlVvLJV/wtH+SIS1YBICCN6uTZAtxFhQZacEmVeAA3ECDXBsKYu
         dD0mM1MobrMt4P+A/GQzeWZovP32wO5U3Qq5zqnueB3lTcUG0tl8Wyvb4ndRC5RInSUN
         /CTqFKsIksGChiNJ9t7qiF5l12HcIozNbueZhORcNj3gBxA5845V0drw9M4PWgLBuzrq
         Yr3UO1l4QaQIBXNgQc/oqBK+fV+h0df4HOwel1II62rG9hfF2ZUo59PXfuwMcg/Gi5Gp
         u9OQ==
X-Gm-Message-State: AOAM530StiyYJPP4cPQk/rS+s3nV5ZOHiLZNS6gGfCae6WHoXHktvePr
        LUWRpz5jQy3E+FTjEUddWodxSsdfKUauGiIBie11I+ZnBGcOBw==
X-Google-Smtp-Source: ABdhPJwM1Hwd0R7YlHFHPNerBxCJ368MvSO2KVCwOH4kBaClxct+rMU6qAeKqeswzAZqlFHor353tQ8uP0DVmHKFrG0=
X-Received: by 2002:a9d:19c8:: with SMTP id k66mr21161530otk.89.1609854162565;
 Tue, 05 Jan 2021 05:42:42 -0800 (PST)
MIME-Version: 1.0
From:   Tom Cook <tom.k.cook@gmail.com>
Date:   Tue, 5 Jan 2021 13:42:31 +0000
Message-ID: <CAFSh4UwMr7t+R9mWUCjdecadJL6=_7jdgagAQK6Y1Yj0+Eu0sg@mail.gmail.com>
Subject: cBPF socket filters failing - inexplicably?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the course of tracking down a defect in some existing software,
I've found the failure demonstrated by the short program below.
Essentially, a cBPF program that just rejects every frame (ie always
returns zero) and is attached to a socket using setsockopt(SOL_SOCKET,
SO_ATTACH_FILTER, ...) still occasionally lets frames through to
userspace.

The code is based on the first example in
Documentation/networking/filter.txt, except that I've changed the
content of the filter program and added a timeout on the socket.

To reproduce the problem:

# gcc test.c -o test
# sudo ./test
... and in another console start a large network operation.

In my case, I copied a ~300MB core file I had lying around to another
host on the LAN.  The test code should print the string "Failed to
read from socket" 100 times.  In practice, it produces about 10%
"Received packet with ethertype..." messages.

I've observed the same result on Ubuntu amd64 glibc system running a
5.9.0 kernel and also on Alpine arm64v8 muslc system running a 4.9.1
kernel.  I've written test code in both C and Python.  I'm fairly sure
this is not something I'm doing wrong - but very keen to have things
thrown at me if it is.

Regards,
Tom Cook


#include <stdio.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <linux/if_ether.h>
#include <linux/filter.h>
#include <stdint.h>
#include <unistd.h>

struct sock_filter code[] = {
    { 0x06,    0,    0,    0x00 }  /* BPF_RET | BPF_K   0   0   0 */
};

struct sock_fprog bpf = {
    .len = 1,
    .filter = code,
};

void test() {
    uint8_t buf[2048];

    int sock = socket(PF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
    if (sock < 0) {
        printf("Failed to open socket\n");
        return;
    }
    int ret = setsockopt(sock, SOL_SOCKET, SO_ATTACH_FILTER, &bpf, sizeof(bpf));
    if (ret < 0) {
        printf("Failed to set socket filter\n");
        return;
    }
    struct timeval tv = {
        .tv_sec = 1
    };

    ret = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
    if (ret < 0) {
        printf("Failed to set socket timeout\n");
        return;
    }

    ssize_t count = recv(sock, buf, 2048, 0);
    if (count <= 0) {
        printf("Failed to read from socket\n");
        return;
    }

    close(sock);

    uint16_t *ethertype = (short*)(buf + 12);
    uint8_t *proto = (unsigned char *)(buf + 23);
    uint16_t *dport = (uint16_t *)(buf + 14 + 20);

    printf("Received packet with ethertype 0x%04hu, protocol 0x%02hhu
and dport 0x%04hu\n", *ethertype, *proto, *dport);
}

int main() {
    for (size_t ii = 0; ii < 100; ++ii) {
        test();
    }
}
