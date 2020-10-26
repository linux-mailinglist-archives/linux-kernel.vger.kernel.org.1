Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BF52997D6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgJZUUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:20:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:30698 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730664AbgJZUTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:19:46 -0400
IronPort-SDR: ikq3eS6mTM4RG0popbiFejBOtMJgktwugzifNaSlVo2UW9QMvwZozxJELnIcrdUwQTdHdF0J6g
 /WGHjppaDaDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147266142"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="gz'50?scan'50,208,50";a="147266142"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 13:19:42 -0700
IronPort-SDR: gxE7um7bwS+bo38w94EB3Q+zmiBpIwKIRxoGVEeze0+Xkh6dIvt/VXnxEGu+BpkTnvrtSX5Vwf
 G2mgnUZDlvRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="gz'50?scan'50,208,50";a="355300422"
Received: from lkp-server01.sh.intel.com (HELO ca9e3ad0a302) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 Oct 2020 13:19:39 -0700
Received: from kbuild by ca9e3ad0a302 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kX8xu-000087-IB; Mon, 26 Oct 2020 20:19:38 +0000
Date:   Tue, 27 Oct 2020 04:19:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arpitha Raghunandan <98.arpi@gmail.com>, brendanhiggins@google.com,
        skhan@linuxfoundation.org, elver@google.com, yzaikin@google.com,
        tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     kbuild-all@lists.01.org, Arpitha Raghunandan <98.arpi@gmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
Message-ID: <202010270419.t5tYXkR9-lkp@intel.com>
References: <20201026183639.82883-1-98.arpi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20201026183639.82883-1-98.arpi@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arpitha,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ext4/dev]
[also build test WARNING on linus/master v5.10-rc1 next-20201026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Arpitha-Raghunandan/kunit-Support-for-Parameterized-Testing/20201027-023812
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
config: m68k-allmodconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1c6cd3899d5ed7da9b746ba887779ca2c89c5bab
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Arpitha-Raghunandan/kunit-Support-for-Parameterized-Testing/20201027-023812
        git checkout 1c6cd3899d5ed7da9b746ba887779ca2c89c5bab
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/err.h:5,
                    from include/kunit/assert.h:12,
                    from include/kunit/test.h:12,
                    from fs/ext4/inode-test.c:7:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   arch/m68k/include/asm/page_mm.h:169:49: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr) ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                 ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   In file included from fs/ext4/inode-test.c:7:
   fs/ext4/inode-test.c: In function 'ext4_inode_gen_params':
>> include/kunit/test.h:1733:58: warning: return discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
    1733 |   return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;   \
   fs/ext4/inode-test.c:214:1: note: in expansion of macro 'KUNIT_PARAM_GENERATOR'
     214 | KUNIT_PARAM_GENERATOR(ext4_inode, test_data);
         | ^~~~~~~~~~~~~~~~~~~~~

vim +/const +1733 include/kunit/test.h

73cda7bb8bfb1d Brendan Higgins     2019-09-23  1152  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1153  #define KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, assert_type, ptr)	       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1154  	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1155  						assert_type,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1156  						ptr,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1157  						NULL)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1158  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1159  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1160   * KUNIT_EXPECT_TRUE() - Causes a test failure when the expression is not true.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1161   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1162   * @condition: an arbitrary boolean expression. The test fails when this does
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1163   * not evaluate to true.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1164   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1165   * This and expectations of the form `KUNIT_EXPECT_*` will cause the test case
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1166   * to fail when the specified condition is not met; however, it will not prevent
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1167   * the test case from continuing to run; this is otherwise known as an
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1168   * *expectation failure*.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1169   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1170  #define KUNIT_EXPECT_TRUE(test, condition) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1171  	KUNIT_TRUE_ASSERTION(test, KUNIT_EXPECTATION, condition)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1172  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1173  #define KUNIT_EXPECT_TRUE_MSG(test, condition, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1174  	KUNIT_TRUE_MSG_ASSERTION(test,					       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1175  				 KUNIT_EXPECTATION,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1176  				 condition,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1177  				 fmt,					       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1178  				 ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1179  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1180  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1181   * KUNIT_EXPECT_FALSE() - Makes a test failure when the expression is not false.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1182   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1183   * @condition: an arbitrary boolean expression. The test fails when this does
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1184   * not evaluate to false.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1185   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1186   * Sets an expectation that @condition evaluates to false. See
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1187   * KUNIT_EXPECT_TRUE() for more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1188   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1189  #define KUNIT_EXPECT_FALSE(test, condition) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1190  	KUNIT_FALSE_ASSERTION(test, KUNIT_EXPECTATION, condition)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1191  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1192  #define KUNIT_EXPECT_FALSE_MSG(test, condition, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1193  	KUNIT_FALSE_MSG_ASSERTION(test,					       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1194  				  KUNIT_EXPECTATION,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1195  				  condition,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1196  				  fmt,					       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1197  				  ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1198  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1199  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1200   * KUNIT_EXPECT_EQ() - Sets an expectation that @left and @right are equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1201   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1202   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1203   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1204   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1205   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1206   * equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1207   * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1208   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1209   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1210  #define KUNIT_EXPECT_EQ(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1211  	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1212  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1213  #define KUNIT_EXPECT_EQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1214  	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1215  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1216  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1217  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1218  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1219  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1220  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1221  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1222   * KUNIT_EXPECT_PTR_EQ() - Expects that pointers @left and @right are equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1223   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1224   * @left: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1225   * @right: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1226   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1227   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1228   * equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1229   * KUNIT_EXPECT_TRUE(@test, (@left) == (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1230   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1231   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1232  #define KUNIT_EXPECT_PTR_EQ(test, left, right)				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1233  	KUNIT_BINARY_PTR_EQ_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1234  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1235  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1236  				      right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1237  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1238  #define KUNIT_EXPECT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1239  	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1240  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1241  					  left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1242  					  right,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1243  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1244  					  ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1245  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1246  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1247   * KUNIT_EXPECT_NE() - An expectation that @left and @right are not equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1248   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1249   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1250   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1251   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1252   * Sets an expectation that the values that @left and @right evaluate to are not
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1253   * equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1254   * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1255   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1256   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1257  #define KUNIT_EXPECT_NE(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1258  	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1259  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1260  #define KUNIT_EXPECT_NE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1261  	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1262  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1263  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1264  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1265  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1266  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1267  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1268  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1269   * KUNIT_EXPECT_PTR_NE() - Expects that pointers @left and @right are not equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1270   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1271   * @left: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1272   * @right: an arbitrary expression that evaluates to a pointer.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1273   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1274   * Sets an expectation that the values that @left and @right evaluate to are not
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1275   * equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1276   * KUNIT_EXPECT_TRUE(@test, (@left) != (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1277   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1278   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1279  #define KUNIT_EXPECT_PTR_NE(test, left, right)				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1280  	KUNIT_BINARY_PTR_NE_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1281  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1282  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1283  				      right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1284  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1285  #define KUNIT_EXPECT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1286  	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1287  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1288  					  left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1289  					  right,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1290  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1291  					  ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1292  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1293  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1294   * KUNIT_EXPECT_LT() - An expectation that @left is less than @right.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1295   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1296   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1297   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1298   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1299   * Sets an expectation that the value that @left evaluates to is less than the
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1300   * value that @right evaluates to. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1301   * KUNIT_EXPECT_TRUE(@test, (@left) < (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1302   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1303   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1304  #define KUNIT_EXPECT_LT(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1305  	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1306  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1307  #define KUNIT_EXPECT_LT_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1308  	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1309  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1310  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1311  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1312  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1313  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1314  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1315  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1316   * KUNIT_EXPECT_LE() - Expects that @left is less than or equal to @right.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1317   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1318   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1319   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1320   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1321   * Sets an expectation that the value that @left evaluates to is less than or
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1322   * equal to the value that @right evaluates to. Semantically this is equivalent
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1323   * to KUNIT_EXPECT_TRUE(@test, (@left) <= (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1324   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1325   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1326  #define KUNIT_EXPECT_LE(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1327  	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1328  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1329  #define KUNIT_EXPECT_LE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1330  	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1331  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1332  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1333  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1334  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1335  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1336  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1337  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1338   * KUNIT_EXPECT_GT() - An expectation that @left is greater than @right.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1339   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1340   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1341   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1342   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1343   * Sets an expectation that the value that @left evaluates to is greater than
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1344   * the value that @right evaluates to. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1345   * KUNIT_EXPECT_TRUE(@test, (@left) > (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1346   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1347   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1348  #define KUNIT_EXPECT_GT(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1349  	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1350  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1351  #define KUNIT_EXPECT_GT_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1352  	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1353  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1354  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1355  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1356  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1357  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1358  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1359  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1360   * KUNIT_EXPECT_GE() - Expects that @left is greater than or equal to @right.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1361   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1362   * @left: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1363   * @right: an arbitrary expression that evaluates to a primitive C type.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1364   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1365   * Sets an expectation that the value that @left evaluates to is greater than
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1366   * the value that @right evaluates to. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1367   * KUNIT_EXPECT_TRUE(@test, (@left) >= (@right)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1368   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1369   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1370  #define KUNIT_EXPECT_GE(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1371  	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1372  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1373  #define KUNIT_EXPECT_GE_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1374  	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1375  				      KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1376  				      left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1377  				      right,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1378  				      fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1379  				      ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1380  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1381  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1382   * KUNIT_EXPECT_STREQ() - Expects that strings @left and @right are equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1383   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1384   * @left: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1385   * @right: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1386   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1387   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1388   * equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1389   * KUNIT_EXPECT_TRUE(@test, !strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1390   * for more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1391   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1392  #define KUNIT_EXPECT_STREQ(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1393  	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1394  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1395  #define KUNIT_EXPECT_STREQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1396  	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1397  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1398  					  left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1399  					  right,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1400  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1401  					  ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1402  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1403  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1404   * KUNIT_EXPECT_STRNEQ() - Expects that strings @left and @right are not equal.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1405   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1406   * @left: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1407   * @right: an arbitrary expression that evaluates to a null terminated string.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1408   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1409   * Sets an expectation that the values that @left and @right evaluate to are
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1410   * not equal. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1411   * KUNIT_EXPECT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_EXPECT_TRUE()
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1412   * for more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1413   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1414  #define KUNIT_EXPECT_STRNEQ(test, left, right) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1415  	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_EXPECTATION, left, right)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1416  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1417  #define KUNIT_EXPECT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1418  	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1419  					  KUNIT_EXPECTATION,		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1420  					  left,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1421  					  right,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1422  					  fmt,				       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1423  					  ##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1424  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1425  /**
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1426   * KUNIT_EXPECT_NOT_ERR_OR_NULL() - Expects that @ptr is not null and not err.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1427   * @test: The test context object.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1428   * @ptr: an arbitrary pointer.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1429   *
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1430   * Sets an expectation that the value that @ptr evaluates to is not null and not
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1431   * an errno stored in a pointer. This is semantically equivalent to
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1432   * KUNIT_EXPECT_TRUE(@test, !IS_ERR_OR_NULL(@ptr)). See KUNIT_EXPECT_TRUE() for
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1433   * more information.
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1434   */
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1435  #define KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ptr) \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1436  	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_EXPECTATION, ptr)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1437  
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1438  #define KUNIT_EXPECT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1439  	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1440  						KUNIT_EXPECTATION,	       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1441  						ptr,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1442  						fmt,			       \
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1443  						##__VA_ARGS__)
73cda7bb8bfb1d Brendan Higgins     2019-09-23  1444  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1445  #define KUNIT_ASSERT_FAILURE(test, fmt, ...) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1446  	KUNIT_FAIL_ASSERTION(test, KUNIT_ASSERTION, fmt, ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1447  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1448  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1449   * KUNIT_ASSERT_TRUE() - Sets an assertion that @condition is true.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1450   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1451   * @condition: an arbitrary boolean expression. The test fails and aborts when
e4aea8f8532b55 Brendan Higgins     2019-09-23  1452   * this does not evaluate to true.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1453   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1454   * This and assertions of the form `KUNIT_ASSERT_*` will cause the test case to
e4aea8f8532b55 Brendan Higgins     2019-09-23  1455   * fail *and immediately abort* when the specified condition is not met. Unlike
e4aea8f8532b55 Brendan Higgins     2019-09-23  1456   * an expectation failure, it will prevent the test case from continuing to run;
e4aea8f8532b55 Brendan Higgins     2019-09-23  1457   * this is otherwise known as an *assertion failure*.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1458   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1459  #define KUNIT_ASSERT_TRUE(test, condition) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1460  	KUNIT_TRUE_ASSERTION(test, KUNIT_ASSERTION, condition)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1461  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1462  #define KUNIT_ASSERT_TRUE_MSG(test, condition, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1463  	KUNIT_TRUE_MSG_ASSERTION(test,					       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1464  				 KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1465  				 condition,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1466  				 fmt,					       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1467  				 ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1468  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1469  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1470   * KUNIT_ASSERT_FALSE() - Sets an assertion that @condition is false.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1471   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1472   * @condition: an arbitrary boolean expression.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1473   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1474   * Sets an assertion that the value that @condition evaluates to is false. This
e4aea8f8532b55 Brendan Higgins     2019-09-23  1475   * is the same as KUNIT_EXPECT_FALSE(), except it causes an assertion failure
e4aea8f8532b55 Brendan Higgins     2019-09-23  1476   * (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1477   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1478  #define KUNIT_ASSERT_FALSE(test, condition) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1479  	KUNIT_FALSE_ASSERTION(test, KUNIT_ASSERTION, condition)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1480  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1481  #define KUNIT_ASSERT_FALSE_MSG(test, condition, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1482  	KUNIT_FALSE_MSG_ASSERTION(test,					       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1483  				  KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1484  				  condition,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1485  				  fmt,					       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1486  				  ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1487  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1488  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1489   * KUNIT_ASSERT_EQ() - Sets an assertion that @left and @right are equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1490   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1491   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1492   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1493   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1494   * Sets an assertion that the values that @left and @right evaluate to are
e4aea8f8532b55 Brendan Higgins     2019-09-23  1495   * equal. This is the same as KUNIT_EXPECT_EQ(), except it causes an assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1496   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1497   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1498  #define KUNIT_ASSERT_EQ(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1499  	KUNIT_BINARY_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1500  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1501  #define KUNIT_ASSERT_EQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1502  	KUNIT_BINARY_EQ_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1503  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1504  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1505  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1506  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1507  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1508  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1509  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1510   * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1511   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1512   * @left: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1513   * @right: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1514   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1515   * Sets an assertion that the values that @left and @right evaluate to are
e4aea8f8532b55 Brendan Higgins     2019-09-23  1516   * equal. This is the same as KUNIT_EXPECT_EQ(), except it causes an assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1517   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1518   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1519  #define KUNIT_ASSERT_PTR_EQ(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1520  	KUNIT_BINARY_PTR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1521  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1522  #define KUNIT_ASSERT_PTR_EQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1523  	KUNIT_BINARY_PTR_EQ_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1524  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1525  					  left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1526  					  right,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1527  					  fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1528  					  ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1529  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1530  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1531   * KUNIT_ASSERT_NE() - An assertion that @left and @right are not equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1532   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1533   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1534   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1535   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1536   * Sets an assertion that the values that @left and @right evaluate to are not
e4aea8f8532b55 Brendan Higgins     2019-09-23  1537   * equal. This is the same as KUNIT_EXPECT_NE(), except it causes an assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1538   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1539   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1540  #define KUNIT_ASSERT_NE(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1541  	KUNIT_BINARY_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1542  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1543  #define KUNIT_ASSERT_NE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1544  	KUNIT_BINARY_NE_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1545  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1546  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1547  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1548  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1549  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1550  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1551  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1552   * KUNIT_ASSERT_PTR_NE() - Asserts that pointers @left and @right are not equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1553   * KUNIT_ASSERT_PTR_EQ() - Asserts that pointers @left and @right are equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1554   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1555   * @left: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1556   * @right: an arbitrary expression that evaluates to a pointer.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1557   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1558   * Sets an assertion that the values that @left and @right evaluate to are not
e4aea8f8532b55 Brendan Higgins     2019-09-23  1559   * equal. This is the same as KUNIT_EXPECT_NE(), except it causes an assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1560   * failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1561   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1562  #define KUNIT_ASSERT_PTR_NE(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1563  	KUNIT_BINARY_PTR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1564  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1565  #define KUNIT_ASSERT_PTR_NE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1566  	KUNIT_BINARY_PTR_NE_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1567  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1568  					  left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1569  					  right,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1570  					  fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1571  					  ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1572  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1573   * KUNIT_ASSERT_LT() - An assertion that @left is less than @right.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1574   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1575   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1576   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1577   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1578   * Sets an assertion that the value that @left evaluates to is less than the
e4aea8f8532b55 Brendan Higgins     2019-09-23  1579   * value that @right evaluates to. This is the same as KUNIT_EXPECT_LT(), except
e4aea8f8532b55 Brendan Higgins     2019-09-23  1580   * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1581   * is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1582   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1583  #define KUNIT_ASSERT_LT(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1584  	KUNIT_BINARY_LT_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1585  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1586  #define KUNIT_ASSERT_LT_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1587  	KUNIT_BINARY_LT_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1588  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1589  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1590  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1591  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1592  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1593  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1594   * KUNIT_ASSERT_LE() - An assertion that @left is less than or equal to @right.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1595   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1596   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1597   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1598   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1599   * Sets an assertion that the value that @left evaluates to is less than or
e4aea8f8532b55 Brendan Higgins     2019-09-23  1600   * equal to the value that @right evaluates to. This is the same as
e4aea8f8532b55 Brendan Higgins     2019-09-23  1601   * KUNIT_EXPECT_LE(), except it causes an assertion failure (see
e4aea8f8532b55 Brendan Higgins     2019-09-23  1602   * KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1603   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1604  #define KUNIT_ASSERT_LE(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1605  	KUNIT_BINARY_LE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1606  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1607  #define KUNIT_ASSERT_LE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1608  	KUNIT_BINARY_LE_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1609  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1610  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1611  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1612  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1613  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1614  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1615  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1616   * KUNIT_ASSERT_GT() - An assertion that @left is greater than @right.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1617   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1618   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1619   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1620   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1621   * Sets an assertion that the value that @left evaluates to is greater than the
e4aea8f8532b55 Brendan Higgins     2019-09-23  1622   * value that @right evaluates to. This is the same as KUNIT_EXPECT_GT(), except
e4aea8f8532b55 Brendan Higgins     2019-09-23  1623   * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1624   * is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1625   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1626  #define KUNIT_ASSERT_GT(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1627  	KUNIT_BINARY_GT_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1628  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1629  #define KUNIT_ASSERT_GT_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1630  	KUNIT_BINARY_GT_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1631  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1632  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1633  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1634  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1635  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1636  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1637  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1638   * KUNIT_ASSERT_GE() - Assertion that @left is greater than or equal to @right.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1639   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1640   * @left: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1641   * @right: an arbitrary expression that evaluates to a primitive C type.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1642   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1643   * Sets an assertion that the value that @left evaluates to is greater than the
e4aea8f8532b55 Brendan Higgins     2019-09-23  1644   * value that @right evaluates to. This is the same as KUNIT_EXPECT_GE(), except
e4aea8f8532b55 Brendan Higgins     2019-09-23  1645   * it causes an assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion
e4aea8f8532b55 Brendan Higgins     2019-09-23  1646   * is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1647   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1648  #define KUNIT_ASSERT_GE(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1649  	KUNIT_BINARY_GE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1650  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1651  #define KUNIT_ASSERT_GE_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1652  	KUNIT_BINARY_GE_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1653  				      KUNIT_ASSERTION,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1654  				      left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1655  				      right,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1656  				      fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1657  				      ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1658  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1659  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1660   * KUNIT_ASSERT_STREQ() - An assertion that strings @left and @right are equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1661   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1662   * @left: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1663   * @right: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1664   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1665   * Sets an assertion that the values that @left and @right evaluate to are
e4aea8f8532b55 Brendan Higgins     2019-09-23  1666   * equal. This is the same as KUNIT_EXPECT_STREQ(), except it causes an
e4aea8f8532b55 Brendan Higgins     2019-09-23  1667   * assertion failure (see KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1668   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1669  #define KUNIT_ASSERT_STREQ(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1670  	KUNIT_BINARY_STR_EQ_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1671  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1672  #define KUNIT_ASSERT_STREQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1673  	KUNIT_BINARY_STR_EQ_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1674  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1675  					  left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1676  					  right,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1677  					  fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1678  					  ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1679  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1680  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1681   * KUNIT_ASSERT_STRNEQ() - Expects that strings @left and @right are not equal.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1682   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1683   * @left: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1684   * @right: an arbitrary expression that evaluates to a null terminated string.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1685   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1686   * Sets an expectation that the values that @left and @right evaluate to are
e4aea8f8532b55 Brendan Higgins     2019-09-23  1687   * not equal. This is semantically equivalent to
e4aea8f8532b55 Brendan Higgins     2019-09-23  1688   * KUNIT_ASSERT_TRUE(@test, strcmp((@left), (@right))). See KUNIT_ASSERT_TRUE()
e4aea8f8532b55 Brendan Higgins     2019-09-23  1689   * for more information.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1690   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1691  #define KUNIT_ASSERT_STRNEQ(test, left, right) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1692  	KUNIT_BINARY_STR_NE_ASSERTION(test, KUNIT_ASSERTION, left, right)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1693  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1694  #define KUNIT_ASSERT_STRNEQ_MSG(test, left, right, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1695  	KUNIT_BINARY_STR_NE_MSG_ASSERTION(test,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1696  					  KUNIT_ASSERTION,		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1697  					  left,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1698  					  right,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1699  					  fmt,				       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1700  					  ##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1701  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1702  /**
e4aea8f8532b55 Brendan Higgins     2019-09-23  1703   * KUNIT_ASSERT_NOT_ERR_OR_NULL() - Assertion that @ptr is not null and not err.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1704   * @test: The test context object.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1705   * @ptr: an arbitrary pointer.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1706   *
e4aea8f8532b55 Brendan Higgins     2019-09-23  1707   * Sets an assertion that the value that @ptr evaluates to is not null and not
e4aea8f8532b55 Brendan Higgins     2019-09-23  1708   * an errno stored in a pointer. This is the same as
e4aea8f8532b55 Brendan Higgins     2019-09-23  1709   * KUNIT_EXPECT_NOT_ERR_OR_NULL(), except it causes an assertion failure (see
e4aea8f8532b55 Brendan Higgins     2019-09-23  1710   * KUNIT_ASSERT_TRUE()) when the assertion is not met.
e4aea8f8532b55 Brendan Higgins     2019-09-23  1711   */
e4aea8f8532b55 Brendan Higgins     2019-09-23  1712  #define KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr) \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1713  	KUNIT_PTR_NOT_ERR_OR_NULL_ASSERTION(test, KUNIT_ASSERTION, ptr)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1714  
e4aea8f8532b55 Brendan Higgins     2019-09-23  1715  #define KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG(test, ptr, fmt, ...)		       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1716  	KUNIT_PTR_NOT_ERR_OR_NULL_MSG_ASSERTION(test,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1717  						KUNIT_ASSERTION,	       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1718  						ptr,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1719  						fmt,			       \
e4aea8f8532b55 Brendan Higgins     2019-09-23  1720  						##__VA_ARGS__)
e4aea8f8532b55 Brendan Higgins     2019-09-23  1721  
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1722  /**
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1723   * KUNIT_PARAM_GENERATOR() - Helper method for test parameter generators
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1724   * 			     required in parameterized tests.
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1725   * @name:  prefix of the name for the test parameter generator function.
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1726   * @prev: a pointer to the previous test parameter, NULL for first parameter.
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1727   * @array: a user-supplied pointer to an array of test parameters.
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1728   */
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1729  #define KUNIT_PARAM_GENERATOR(name, array)							\
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1730  	static void *name##_gen_params(void *prev)						\
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1731  	{											\
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1732  		typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);	\
6b4ee29da75136 Arpitha Raghunandan 2020-10-27 @1733  		return __next - (array) < ARRAY_SIZE((array)) ? __next : NULL;			\
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1734  	}
6b4ee29da75136 Arpitha Raghunandan 2020-10-27  1735  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--vtzGhvizbBRQ85DL
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--vtzGhvizbBRQ85DL--
